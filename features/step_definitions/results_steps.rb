Given /^game "([^"]*)" result confirmation process between "([^"]*)" and "([^"]*)" for today initiated by "([^"]*)"$/ do |game_desc, team1_name, team2_name, initiating_team|
  game = Game.where(:description=> game_desc).first
  game.create_result(:team1 => 6, :team2 => 3)
end

When /^I enter "([^"]*)"\-"([^"]*)" as game result$/ do |team1_result, team2_result|
  within "form#new_result" do
    fill_in "result[0[team1]]", :with => team1_result
    fill_in "result[0[team2]]", :with => team2_result
  end
end

When /^#{capture_model} clicks in the "([^"]*)" button of the received game result confirmation email$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^#{capture_model} should receive a game "([^"]*)" result confirmation email$/ do |player_ref, game_desc|
  pending # express the regexp above with the code you wish you had
end

Then /^#{capture_model} should receive a game "([^"]*)" result cancellation email$/ do |player_ref, game_desc|
  pending # express the regexp above with the code you wish you had
end
