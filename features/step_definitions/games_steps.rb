
Given /^an existing and confirmed friendly game between "([^"]*)" and "([^"]*)" for today$/ do |team1_name, team2_name|
  Game.create_friendly(Team.find_by_name(team1_name),
                       Team.find_by_name(team2_name),
                       Date.today + 12.hours)
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
  pending # express the regexp above with the code you wish you had
end
