class Player < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true,  :uniqueness => true

  has_many :teams, :finder_sql => 'select * from teams t where t.player1_id = #{id} or t.player2_id = #{id}'

  devise :database_authenticatable, :omniauthable, :rememberable
  before_create :init_devise_password

  def self.find_or_create_by_name_and_email(facebook_id,name,email)
    Player.find_by_facebook_id(facebook_id) ||
    Player.create(:name => name, :email => email, :facebook_id => facebook_id)
  end
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    player = Player.find_or_create_by_name_and_email(data["id"],data["name"],data["email"])
  end

  def self.new_with_session(params, session)
    super.tap do |player|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        player.email = data["email"]
      end
    end
  end

  def facebook_url
    "http://graph.facebook.com/#{facebook_id}"
  end
  private

  def init_devise_password
    password = Devise.friendly_token[0,20]
  end
end
