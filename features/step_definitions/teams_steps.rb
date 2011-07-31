
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

Then /^"([^"]*)" should receive a "([^"]*)" membership ask email from "([^"]*)"$/ do |confirmation_player_email, team_name, initiator_player|
  email = ActionMailer::Base.deliveries.first
  email.should_not be_blank
  email.to.should be_include(confirmation_player_email)
  email.subject.should == "Padelotron. #{initiator_player} wants you to join a team"
  email.body.should be_include "#{initiator_player} has created a team named #{team_name} in Padelotron and he wants you to join it!"
end

Given /^a "([^"]*)" team creation process for "([^"]*)" and "([^"]*)" initiated by "([^"]*)"$/ do |team_name, player1, player2, initiating_player|
  Team.create(:name => team_name,
              :player1 => Player.find_by_name(player1),
              :player2 => Player.find_by_name(player2))
end

When /^I click in the "([^"]*)" button of the received email$/ do |button|
  email = ActionMailer::Base.deliveries.first
  email.should_not be_blank
  confirm_url,reject_url = email.body.to_s.scan /\/confirmations\/\d*/
  next_url = button == 'Confirm' ? confirm_url : reject_url
  ActionMailer::Base.deliveries.delete(email)
  visit next_url
end

Then /^"([^"]*)" should receive a "([^"]*)" membership confirmation email$/ do |player, team_name|
  email = ActionMailer::Base.deliveries.first
  email.should_not be_blank
  email.to.should be_include(player)
  email.subject.should == "Padelotron. You joined #{team_name}"
  email.body.should be_include "You just joined the team #{team_name}"
  
end

Then /^"([^"]*)" should receive a "([^"]*)" team cancelation email$/ do |player, team_name|
  email = ActionMailer::Base.deliveries.first
  email.should_not be_blank
  email.to.should be_include(player)
  email.subject.should == "Padelotron. You rejected joining #{team_name}"
  email.body.should be_include "You just rejected joining the team #{team_name}."  
end


Given /^an existing and confirmed team "([^"]*)" for "([^"]*)" and "([^"]*)"$/ do |team_name, player1_name, player2_name|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see '(\d+)' team listed$/ do |team_count|
  pending # express the regexp above with the code you wish you had
  # usad team_count.to_i (casting a Integer) para comprobar q hay team_count objetos DOM q muestran equipos...
end

Then /^I should see team "([^"]*)" basic info with "([^"]*)" and "([^"]*)"$/ do |team_name, player1_name, player2_name|
  pending # express the regexp above with the code you wish you had
end

Then /^I should not see team "([^"]*)" basic info$/ do |team_name|
  pending # express the regexp above with the code you wish you had
end

