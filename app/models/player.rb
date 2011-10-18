class Player < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true,  :uniqueness => true

  has_many :teams, :finder_sql => 'select * from teams t where t.player1_id = #{id} or t.player2_id = #{id}'
  has_many :notifications
  has_many :player_games, :class_name => "Game", :finder_sql => 'select * from games '
  
  include Statable

  devise :database_authenticatable, :omniauthable, :rememberable
  before_create :init_devise_password
  before_create :geocode_with_gmaps
  before_update :geocode_with_gmaps
  after_create :create_welcome_notification, :create_geographic_location_notification_if_needed
  #vaya mie4rda
  #--

  geocoded_by :full_address

  scope :by_letter, lambda{ |letter|
    where("lower(name) like ?", "#{letter.downcase}%")
  }

  def self.find_or_create_by_name_and_email(facebook_id,name,email)
    Player.find_by_facebook_id(facebook_id) ||
      Player.create(:name => name, :email => email, :facebook_id => facebook_id)
  end
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    player = Player.find_or_create_by_name_and_email(data["id"],data["name"],data["email"])
    if player.full_address.blank?
      player.full_address = data['location']['name'] if data['location']
      player.save
    end
    player
  end

  def self.new_with_session(params, session)
    super.tap do |player|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        player.email = data["email"]
      end
    end
  end

  def as_json(options={})
    {
      :name => name,
      :facebook_id => facebook_id,
      :id => id
    }
  end
  
  def facebook_url
    "http://graph.facebook.com/#{facebook_id}"
  end
  private

  def create_geographic_location_notification_if_needed
    unless self.geocoded?
      self.notifications.create(NotificationType.ASK_PLAYER_LOCATION(self))
    end
  end

  def geocode_with_gmaps
    return true if self.full_address.blank?
    require 'open-uri'
    address = "address=#{CGI.escape self.full_address}"
    response = open("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&#{address}").readlines.join
    logger.debug "Geocoder: response #{response}"
    location_data = JSON.parse(response)['results']
    unless location_data.blank?
      loc = location_data.first
      self.full_address= loc['formatted_address']
      self.latitude = loc['geometry']['location']['lat']
      self.longitude = loc['geometry']['location']['lng']
      self.country = get_geocode_attribute_value(loc, "country")
      self.city = get_geocode_attribute_value(loc, "locality")
      self.street = "#{get_geocode_attribute_value(loc, "route")} #{get_geocode_attribute_value(loc, "street_number")}"
      self.area_level1 = get_geocode_attribute_value(loc, "administrative_area_level_1")
      self.area_level2 = get_geocode_attribute_value(loc, "administrative_area_level_2")
    end
  end

  def get_geocode_attribute_value(loc, att)
    attribute = loc['address_components'].select { |comp|
      comp['types'].include?(att) }.first
    attribute['long_name'] if attribute
  end
  
  def init_devise_password
    password = Devise.friendly_token[0,20]
  end

  def create_welcome_notification
    notification= NotificationType.NEW_PLAYER(self)
    notification[:params][:name] = self.name
    notifications.create notification
  end
end
