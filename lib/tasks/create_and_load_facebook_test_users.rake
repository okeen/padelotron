#encoding: utf-8

task :create_and_load_facebook_test_users => :environment do
  require 'koala'

  @@file_name = "db/fb_test_users.yaml"

  def next_name(player_number)
    first_letter = ((player_number / 24).to_i + 97).chr
    second_letter = ((player_number % 24).to_i + 97).chr
    "player #{first_letter}#{second_letter}"
  end

  def create_facebook_user(name, with_app_installed)
    begin
      puts "Creating player #{name}"
      user = @test_users.create(with_app_installed, "email", {:name => name})
      puts "Created user #{user.inspect}, #{with_app_installed}"
      @current_test_users << user.merge('name'=> name)
    rescue => e
      puts "Error creating #{name}: #{e.inspect}"
    end
  end

  id= '270031589679955'
  secret = '4e4e4c8e723e2bf6df566624161a543c'
  @test_users = Koala::Facebook::TestUsers.new(:app_id => id, :secret => secret)
  puts "Connected with Facebook"

  @current_test_users = File.exists?(@@file_name) ?
      YAML.load(File.open(@@file_name)) : []
  puts "Loaded App test users: #{@current_test_users}"

  @current_test_users.count.upto 200 do |index|
      name = next_name(index)
      create_facebook_user(name, true)
  end
  
  #create 5 users with the app still uninstalled
  5.times do |index|
      name = next_name(index) + " un"
      create_facebook_user(name, false)
  end

  File.open("db/fb_test_users.yaml", "w") { |file|
    file.puts(@current_test_users.to_yaml)
  }

end