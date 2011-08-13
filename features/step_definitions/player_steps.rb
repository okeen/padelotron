
Given /^an existing player "([^"]*)" with email "([^"]*)"$/ do |name, email|
  Player.create :name => name, :email => email
end


When /^I enter "([^"]*)" as username and "([^"]*)" as email$/ do |name, email|
  within "form#new_player" do
    fill_in "player_name", :with => name
    fill_in "player_email", :with => email
  end
end

Then /^I should see the recently created player with name "([^"]*)" and email "([^"]*)"$/ do |name,email|
  page.should have_selector("p", :content => name)
  page.should have_selector( "p", :content => email)
end


When /^I enter #{capture_model} 's email as Email$/ do |player_ref|
  player = model(player_ref)
  within_window "Log In | Facebook" do
      fill_in 'Email:', :with => player.email
  end
end

When /^I enter #{capture_model} 's password as Password$/ do |player_ref|
  player = model(player_ref)
  within_window "Log In | Facebook" do
      fill_in 'Password:', :with => player.encrypted_password
  end
end

When /^I login as #{capture_model}$/ do |player_ref|
  player = model(player_ref)
  login_as player, :scope => :player
  visit root_path
  page.should have_content "Kaixo #{player.name}"
end
