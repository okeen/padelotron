
Given /^an existing and confirmed friendly game between "([^"]*)" and "([^"]*)" for today$/ do |team1_name, team2_name|
  game = Game.create_friendly(Team.find_by_name(team1_name),
                       Team.find_by_name(team2_name),
                       Date.today + 12.hours)
  game.confirm!
  #skip the sent email, it's already confirmed so we are not testing that
  ActionMailer::Base.deliveries.clear
end

When /^I select "([^"]*)" as first team$/ do |first_team_name|
  select first_team_name, :from => "game_team1_id"
end

When /^I select "([^"]*)" as second team$/ do |second_team_name|
  select second_team_name, :from => "game_team2_id"
end

When /^I select '(\d+)'\/"([^"]*)"\/'(\d+)', '(\d+)':'(\d+)' as play date$/ do |day, month, year, hours, minutes|
  select day, :from => 'game_play_date_3i'
  select month, :from => 'game_play_date_2i'
  select year, :from => 'game_play_date_1i'
  select hours, :from => 'game_play_date_4i'
  select minutes, :from => 'game_play_date_5i'
end

Then /^"([^"]*)" should receive a friendly game offer from "([^"]*)" for '(\d+)'\/'(\d+)'\/'(\d+)', '(\d+)':'(\d+)'$/ do |player_email, rival_team_name, day, month, year, hours, minutes|
  email = ActionMailer::Base.deliveries.last
  email.should_not be_blank
  email.to.should be_include(player_email)
  email.subject.should == "Friendly game offer from #{rival_team_name} received" 
  email.body.should be_include("You received an offer to play a padel game against #{rival_team_name} at #{day}/#{month}/#{year}, #{hours}:#{minutes}")
end

Given /^a friendly game creation process between "([^"]*)" and "([^"]*)" for today initiated by "([^"]*)"$/ do |team1_name, team2_name, initiating_team_name|
  game = Game.create_friendly(Team.find_by_name(team1_name),
                       Team.find_by_name(team2_name),
                       Date.today + 12.hours)
end

When /^"([^"]*)" click in the "([^"]*)" button of the received friendly confirmation email$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

