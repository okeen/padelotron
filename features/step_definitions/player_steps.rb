
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
