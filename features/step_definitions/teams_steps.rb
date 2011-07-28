
When /^I enter "([^"]*)" as team name$/ do |team_name|
  within "form#new_team" do |form|
    fill_in "team_name", :with => team_name
  end
end

When /^I select "([^"]*)" as team mate$/ do |team_mate_name|
  select team_mate_name, :from => "team_player2_id"
end

When /^I select "([^"]*)" as first player$/ do |first_player_name|
  select first_player_name, :from => "team_player1_id"
end

Then /^"([^"]*)" should receive a "([^"]*)" membership ask email from "([^"]*)"$/ do |confirmation_player, team_name, initiator_player|
  email = ActionMailer::Base.deliveries.first
  email.should_not be_blank
  puts email.inspect
  email.to.should be_include(confirmation_player_email)
  email.subject.should == "Padelotron. #{initiator_player} wants you to join a team"
  email.body.should be_include "#{initiator_player} has created a team named #{team_name} in Padelotron and he wants you to join it!"
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
