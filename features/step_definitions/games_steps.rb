
Given /^an existing and confirmed friendly game between "([^"]*)" and "([^"]*)" for today$/ do |team1_name, team2_name|
  Game.create_friendly(Team.find_by_name(team1_name),
                       Team.find_by_name(team2_name),
                       Date.today + 12.hours)
end

When /^I select "([^"]*)" as first team$/ do |first_team_name|
  pending # express the regexp above with the code you wish you had
end

When /^I select "([^"]*)" as second team$/ do |second_team_name|
  pending # express the regexp above with the code you wish you had
end

When /^I select '(\d+)'\/'(\d+)'\/'(\d+)', '(\d+)':'(\d+)' as play date$/ do |day, month, year, hours, minutes|
  pending # express the regexp above with the code you wish you had
end

Then /^"([^"]*)" should receive a friendly game offer from "([^"]*)" for '(\d+)'\/'(\d+)'\/'(\d+)', '(\d+)':'(\d+)'$/ do |player_email, rival_team_name, day, month, year, hours, minutes|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see '(\d+)' teams listed$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
