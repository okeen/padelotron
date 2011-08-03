Given /^game "([^"]*)" result confirmation process between "([^"]*)" and "([^"]*)" for today initiated by "([^"]*)"$/ do |game_desc, team1_name, team2_name, initiating_team|
  game = Game.where(:description=> game_desc).first
  game.create_result(:team1 => 6, :team2 => 3)
end

When /^I enter "([^"]*)"\-"([^"]*)" as game result$/ do |team1_result, team2_result|
  pending # express the regexp above with the code you wish you had
end
