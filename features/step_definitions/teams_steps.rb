
When /^I confirm the team "([^"]*)"$/ do |team_name|
  Team.send(:with_exclusive_scope) {Team.find_by_name(team_name).confirm!}
end

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

Then /^#{capture_model} should receive a "([^"]*)" membership ask email from "([^"]*)"$/ do |player_ref, team_name, initiator_player|
  player = model(player_ref)
  email = ActionMailer::Base.deliveries.last
  email.should_not be_blank
  email.to.should be_include(player.email)
  email.subject.should == "Padelotron. #{initiator_player} wants you to join a team"
  email.body.should be_include "#{initiator_player} has created a team named #{team_name} in Padelotron and he wants you to join it!"
end

Given /^a "([^"]*)" team creation process for "([^"]*)" and "([^"]*)" initiated by "([^"]*)"$/ do |team_name, player1, player2, initiating_player|
  team = Team.create(:name => team_name,
    :player1 => Player.find_by_name(player1),
    :player2 => Player.find_by_name(player2))
end

When /^#{capture_model} clicks in the "([^"]*)" button of the received email$/ do |player_ref,button|
  player = model(player_ref)
  login_as player, :scope => :player
  email = ActionMailer::Base.deliveries.first
  email.should_not be_blank
  confirm_url,reject_url = email.body.to_s.scan /\/confirmations\/\d*/
  confirm_url.should_not be_blank
  reject_url.should_not be_blank
  next_url = button == 'Confirm' ? confirm_url : reject_url
  ActionMailer::Base.deliveries.delete(email)
  visit next_url
end

Then /^#{capture_model} should receive a "([^"]*)" membership confirmation email$/ do |player_ref, team_name|
  player = model(player_ref)
  email = ActionMailer::Base.deliveries.last
  email.should_not be_blank
  email.to.should be_include(player.email)
  email.subject.should == "Padelotron. You joined #{team_name}"
  email.body.should be_include "You just joined the team #{team_name}"
end

Then /^#{capture_model} should receive a "([^"]*)" membership cancellation email$/ do |player_ref, team_name|
  player = model(player_ref)
  email = ActionMailer::Base.deliveries.last
  email.should_not be_blank
  email.to.should be_include(player.email)
  email.subject.should == "Padelotron. You rejected joining #{team_name}"
  email.body.should be_include "You just rejected joining the team #{team_name}."  
end


Given /^an existing and confirmed team "([^"]*)" for "([^"]*)" and "([^"]*)"$/ do |team_name, player1_name, player2_name|
  team = Team.create( :name => team_name,
    :player1 => Player.find_by_name(player1_name),
    :player2 => Player.find_by_name(player2_name)
  )
  team.confirm!
  ActionMailer::Base.deliveries.clear
end

Then /^I should see '(\d+)' teams listed$/ do |team_count|
  if team_count == '0'
    page.should_not have_selector("div.team_panel")
  else
    # usad team_count.to_i (casting a Integer) para comprobar q hay team_count objetos DOM q muestran equipos...
    page.should have_selector("div.team_panel", :count => team_count.to_i)
  end
end

Then /^I should see team "([^"]*)" basic info with "([^"]*)" and "([^"]*)"$/ do |team_name, player1_name, player2_name|
  page.should have_xpath("//h4/a[text()='#{team_name}']")
  page.should have_selector("li.player", :content => player1_name)
  page.should have_selector("li.player", :content => player2_name)
end

Then /^I should not see team "([^"]*)" basic info$/ do |team_name|
  page.should_not have_xpath("//h4[text()='#{team_name}']")
end

Then /^I should see a like button for team with name "([^"]*)"$/ do |team_name|
  Capybara.default_wait_time = 5
  Capybara.ignore_hidden_elements = false

  #page.should have_selector "a.connect_widget_like_button.like_button_like"
end

When /^I press the like button of team with name "([^"]*)"$/ do |team_name|
  Capybara.default_wait_time = 5
  Capybara.ignore_hidden_elements = false
  within "div.facebook_like_panel" do
    #click_on "Like"
    link = page.find(:xpath, "//a[@class='connect_widget_like_button']", :visible => false).first
    link.should_not be_blank
    link.click
  end
end
