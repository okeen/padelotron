FactoryGirl.define do

  unless File.exists? "db/fb_test_users.yaml"
    raise "Please generate first the facebook test users file"
  end
  @facebook_players = YAML.load(File.open("db/fb_test_users.yaml"))
  #offset where uninstalled players start in the list
  @offset = @facebook_players.count - 5

  
  sequence :player_name do |n|
    @facebook_players[n-1]['name']
  end

  sequence :password do |n|
    @facebook_players[n-1]['password']
  end

  sequence :email do |n|
    @facebook_players[n-1]['email']
  end

  sequence :facebook_id do |n|
    @facebook_players[n-1]['id'].to_i
  end

  factory :player do
    name {Factory.next(:player_name)}
    email {Factory.next(:email)}
    password {Factory.next :password}
    password_confirmation {"#{password}"}
    facebook_id {Factory.next :facebook_id}
    country {Factory.next :place_country}
    city {Factory.next :place_city}
    street {Factory.next :place_street}
    latitude {42.88256 + (rand) - 0.5}
    longitude {(-8.535357) + (rand) - 0.5}
    full_address {"#{street}, #{city}, #{country}"}

  end

  sequence :unconnected_player_name do |n|
    @facebook_players[@offset + n]['name']
  end

  sequence :unconnected_password do |n|
    @facebook_players[@offset + n]['password']
  end

  sequence :unconnected_email do |n|
    @facebook_players[@offset + n]['email']
  end

  sequence :unconnected_facebook_id do |n|
    @facebook_players[@offset + n]['id'].to_i
  end

  factory :unconnected_player, :class => 'Player' do
    name {Factory.next(:unconnected_player_name)}
    email {Factory.next(:unconnected_email)}
    password {Factory.next :unconnected_password}
    password_confirmation {"#{password}"}
    encrypted_password {"#{password}"}
    facebook_id {Factory.next :unconnected_facebook_id}
    country {Factory.next :place_country}
    city {Factory.next :place_city}
    street {Factory.next :place_street}
    latitude {42.88256 + (rand) - 0.5}
    longitude {(-8.535357) + (rand) - 0.5}
    full_address {"#{street}, #{city}, #{country}"}

  end

end