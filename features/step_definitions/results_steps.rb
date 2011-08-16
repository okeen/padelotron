Given /^game "([^"]*)" result confirmation process between "([^"]*)" and "([^"]*)" for today initiated by "([^"]*)"$/ do |game_desc, team1_name, team2_name, initiating_team|
  game = Game.where(:description=> game_desc).first
  game.create_result(:team1 => 6, :team2 => 3)
end

When /^I enter "([^"]*)"\-"([^"]*)" as game result$/ do |team1_result, team2_result|
  within "form#new_result" do
    fill_in "result[result_sets][0][team1]", :with => team1_result
    fill_in "result[result_sets][0][team2]", :with => team2_result
  end
end

Given /^the following result confirmation process for the game "([^"]*)":$/ do |game_desc, result_sets_table|
  # table is a Cucumber::Ast::Table
  sets = {}
  result_sets_table.hashes.each  do |set_data|
    sets[set_data[:set_num]]={:team1 => set_data[:team1], :team2 => set_data[:team2]}
  end
  Game.find_by_description(game_desc).create_result(:result_sets => sets)
end


When /^#{capture_model} clicks in the "([^"]*)" button of the received game result confirmation email$/ do |player_ref, button|
  player = model(player_ref)
  login_as player, :scope => :player
  email = ActionMailer::Base.deliveries.last
  email.should_not be_blank
  email.to.should be_include(player.email)
  confirm_url,reject_url = email.body.to_s.scan /\/confirmations\/\d*/
  next_url = button == 'Confirm' ? confirm_url : reject_url
  ActionMailer::Base.deliveries.delete(email)
  visit next_url
end

Then /^#{capture_model} should receive a game "([^"]*)" result confirmation email$/ do |player_ref, game_desc|
  player = model(player_ref)
  player.should_not be_blank
  email = ActionMailer::Base.deliveries.select {|email| email.to.include?(player.email) }.last
  email.should_not be_blank
  email.subject.should == "Game result for game #{game_desc} confirmed"
  email.body.should be_include("You confirmed the result of the game #{game_desc}")
end

Then /^#{capture_model} should receive a game "([^"]*)" result cancellation email$/ do |player_ref, game_desc|
  player = model(player_ref)
  player.should_not be_blank
  email = ActionMailer::Base.deliveries.select {|email| email.to.include?(player.email) }.last
  email.should_not be_blank
  email.subject.should == "Game result for game #{game_desc} cancelled"
  email.body.should be_include("You cancelled the result of the game #{game_desc}")
end