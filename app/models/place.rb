class Place < ActiveRecord::Base
  has_many :playgrounds
  has_many :games, :through => :playgrounds
  
  before_create  :geocode_with_gmaps
  after_create :create_playgrounds

  belongs_to :customer

  default_scope includes(:playgrounds)
  
  def address
    [street, city, state, country].compact.join(', ')
  end

  private

  def create_playgrounds
    playgrounds.create(:name => self.name, :sport => "padel")
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
      self.street = "#{get_geocode_attribute_value(loc, "route")} #{get_geocode_attribute_value(loc, "street_number")}"
      self.city = get_geocode_attribute_value(loc, "locality")
      self.area_level1 = get_geocode_attribute_value(loc, "administrative_area_level_1")
      self.area_level2 = get_geocode_attribute_value(loc, "administrative_area_level_2")
    end
  end


  def get_geocode_attribute_value(loc, att)
    attribute = loc['address_components'].select { |comp|
      comp['types'].include?(att) }.first
    attribute['long_name'] if attribute
  end
end
