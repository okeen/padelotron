
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
  Capybara.default_wait_time= 5
  player = model(player_ref)
  puts player.inspect
  within_window "Log In | Facebook" do
      fill_in 'Email:', :with => player.email
  end
end

When /^I enter #{capture_model} 's password as Password$/ do |player_ref|
  player = model(player_ref)
  password = FacebookTestUsers.named(player.name)['password']
  within_window "Log In | Facebook" do
      fill_in 'Password:', :with => password
  end
end

When /^I login as #{capture_model}$/ do |player_ref|
  player = model(player_ref)
  scope = player.class == Player ? :player : :customer
  login_as player, :scope => scope
  visit root_path
end

Given /^I am not logged$/ do
  logout
end

Then /^I should see #{capture_model}'s name$/ do |player_ref|
  player = model(player_ref)
  page.should have_content player.name
end

Then /^I should see #{capture_model}'s photo$/ do |player_ref|
  player = model(player_ref)
  page.should have_xpath "//img[@src='#{player.facebook_url}/picture?type=large']"
end

Then /^I should see a like button for #{capture_model}$/ do |player_ref|
  player = model(player_ref)
  page.should have_xpath "//fb:like"
end

When /^I press the like button of #{capture_model}$/ do |player_ref|
  player = model(player_ref)
end

When /^I press the FB "([^"]*)" button$/ do |button|
  Capybara.default_wait_time= 5
  page.find("a.fb_button").click
end

When /^I press "([^"]*)" in Facebook$/ do |button_name|
  within_window "Log In | Facebook" do
    When "I press \"Log In\""
  end
end
