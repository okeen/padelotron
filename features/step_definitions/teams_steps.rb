
When /^I enter "([^"]*)" as team name$/ do |team_name|
  within "form#new_team" do |form|
    fill_in "team_name", :with => team_name
  end
end

When /^I select "([^"]*)" as team mate$/ do |team_mate_name|
  pending # express the regexp above with the code you wish you had
end

Then /^"([^"]*)" should receive a "([^"]*)" membership ask email from "([^"]*)"$/ do |confirmation_player, team_name, initiator_player|
  email = ActionMailer::Base.deliveries.first
  email.to.should == confirmation_player.email  
end

Given /^a "([^"]*)" team creation process for "([^"]*)" and "([^"]*)" initiated by "([^"]*)"$/ do |team_name, player1, player2, initiating_player|
  pending # express the regexp above with the code you wish you had
end

When /^I click in the "([^"]*)" button of the received email$/ do |button|
  pending # express the regexp above with the code you wish you had
end

Then /^"([^"]*)" should receive a "([^"]*)" membership confirmation email$/ do |player, team_name|
  pending # express the regexp above with the code you wish you had
end

Then /^"([^"]*)" should receive a "([^"]*)" team cancelation email$/ do |player, team_name|
  pending # express the regexp above with the code you wish you had
end
