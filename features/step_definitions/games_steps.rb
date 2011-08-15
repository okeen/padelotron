Given /^the date is "([^"]*)"$/ do |date_string|
  Timecop.travel Chronic.parse("#{date_string}")
end

Given /^an existing and confirmed friendly game "([^"]*)" between "([^"]*)" and "([^"]*)" for today$/ do |game_desc, team1_name, team2_name|
  game = Game.create(:team1       => Team.find_by_name(team1_name),
                     :team2       => Team.find_by_name(team2_name),
                     :play_date   => Date.today + 12.hours,
                     :description => game_desc )
  game.confirm!
  #skip the sent email, it's already confirmed so we are not testing that
  ActionMailer::Base.deliveries.clear
end

When /^I confirm the game "([^"]*)"$/ do |game_description|
  Game.send(:with_exclusive_scope) {Game.find_by_description(game_description)}.confirm!
end

When /^I select #{capture_model} as first team$/ do |first_team_name|
  name = model(first_team_name).name
  select name, :from => "game_team1_id"
end

When /^I select #{capture_model} as second team$/ do |second_team_name|
  name = model(second_team_name).name
  select name, :from => "game_team2_id"
end

When /^I select '(\d+)'\/"([^"]*)"\/'(\d+)', '(\d+)':'(\d+)' as play date$/ do |day, month, year, hours, minutes|
  select day, :from => 'game_play_date_3i'
  select month, :from => 'game_play_date_2i'
  select year, :from => 'game_play_date_1i'
  select hours, :from => 'game_play_date_4i'
  select minutes, :from => 'game_play_date_5i'
end

Then /^#{capture_model} should receive a friendly game offer from #{capture_model} for '(\d+)'\/'(\d+)'\/'(\d+)', '(\d+)':'(\d+)'$/ do |player_name, rival_team_name, day, month, year, hours, minutes|
  player = model(player_name)
  rival_team = model(rival_team_name)
  email = ActionMailer::Base.deliveries.last
  email.should_not be_blank
  email.to.should be_include(player.email)
  email.subject.should == "Friendly game offer from #{rival_team.name} received"
  email.body.should be_include("You received an offer to play a padel game against #{rival_team.name} at #{day}/#{month}/#{year}, #{hours}:#{minutes}")
end

Given /^a friendly game "([^"]*)" creation process between "([^"]*)" and "([^"]*)" for today initiated by "([^"]*)"$/ do |game_description, team1_name, team2_name, initiating_team_name|
  game = Game.create(:team1 => Team.find_by_name(team1_name),
                     :team2 => Team.find_by_name(team2_name),
                     :play_date =>  Date.today + 12.hours)
end

When /^#{capture_model} clicks in the "([^"]*)" button of the received friendly confirmation email$/ do |player_name, button|
  player = model(player_name)
  login_as player, :scope => :player
  email = ActionMailer::Base.deliveries.last
  email.should_not be_blank
  email.to.should be_include(player.email)
  confirm_url,reject_url = email.body.to_s.scan /\/confirmations\/\d*/
  next_url = button == 'Confirm' ? confirm_url : reject_url
  ActionMailer::Base.deliveries.delete(email)
  visit next_url
end

Then /^#{capture_model} should receive a friendly game against "([^"]*)" confirmation email$/ do |player_name, rival_team_name|
  player = model(player_name)
  player.should_not be_blank
  email = ActionMailer::Base.deliveries.select {|email| email.to.include?(player.email) }.last
  email.should_not be_blank
  email.subject.should == "Friendly game against #{rival_team_name} confirmed"
  email.body.should be_include("You confirmed a friendly game against #{rival_team_name}")
end

Then /^#{capture_model} should receive a friendly game against "([^"]*)" cancellation email$/ do |player_name, rival_team_name|
  player = model(player_name)
  player.should_not be_blank
  email = ActionMailer::Base.deliveries.select {|email| email.to.include?(player.email) }.last
  email.should_not be_blank
  email.subject.should == "Friendly game against #{rival_team_name} cancelled"
  email.body.should be_include("You cancelled a friendly game against #{rival_team_name}")
end


Then /^I should see '(\d+)' games listed$/ do |game_count|
  page.should have_selector("div.game_panel", :count => game_count.to_i)
end

Then /^I should see the game "([^"]*)" between "([^"]*)" and "([^"]*)" for today at "([^"]*)":"([^"]*)"$/ do |game_desc, team1_name, team2_name, hours, minutes|
  page.should have_selector("div.game_panel a h4", :content => game_desc) do |game_elem|
    game_elem.should have_selector("div.game_teams_subpanel div.first_team", :content => team1_name)
    game_elem.should have_selector("div.game_teams_subpanel div.second_team", :content => team2_name)
    game_elem.should have_selector("h4.play_date", :content => "#{hours}:#{minutes}")
  end
end

Then /^I should not see the game "([^"]*)" between "([^"]*)" and "([^"]*)" for today at "([^"]*)":"([^"]*)"$/ do |game_desc, team1_name, team2_name, hours, minutes|
  page.should_not have_selector("div.game_panel a h4", :content => game_desc)
end

When /^I click on the game "([^"]*)" between "([^"]*)" and "([^"]*)" for today$/ do |game_desc, team1, team2|
    click_link game_desc
end

Then /^I should see today at "([^"]*)":"([^"]*)" as game play date$/ do |hours, minutes|
  page.should have_selector("h4.play_date", :content => "#{hours}:#{minutes}")
end

