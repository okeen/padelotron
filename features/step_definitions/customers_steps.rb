
When /^I select the first map result$/ do
  within "ul#geocoded_results" do
    page.find("li.geocoded_place a").click
  end

end

Then /^I should be the free subscription type purchase page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^we should have '(\d+)\.(\d+)' total earnings from #{capture_model}'s subscriptions$/ do |euros, cents, customer_ref|
  customer = model(customer_ref)
  puts "Expecting #{euros}#{cents.to_f / 100}"
  customer.subscriptions.collect(&:total_revenue).sum.should == (euros.to_i + (cents.to_f / 100))
end

Then /^we should have '(\d+)\.(\d+)' total earnings from all the subscriptions$/ do |euros, cents|
  puts "Expecting total #{euros}#{cents.to_f / 100}"
  Subscription.all.collect(&:total_revenue).sum.should == (euros.to_i + (cents.to_f / 100))
end


Then /^I save the page$/ do
  puts page.inspect
end

When /^I follow the "([^"]*)" subscription link$/ do |subscription_link_text|
  visit page.find("a.product", :text => subscription_link_text)['href']
end


Given /^#{capture_model} has the following playgrounds:$/ do |customer_ref, playgrounds_table|
  customer = model(customer_ref)
  customer.places.create({:name => "Customer#{customer.id} place "}) unless customer.places.count > 0
  place = customer.places.first
  playgrounds_table.hashes.each do |playground_data|
    place.playgrounds.create(playground_data)
  end
end


Then /^I should see '(\d+)' games with confirmation pending with:$/ do |game_count, game_table|
  game_table.hashes.each do |game_data|
    team1 = model(game_data['team1'])
    team2 = model(game_data['team2'])
    page.should have_selector "div.dhx_cal_event",
       :content => "#{team1.name} VS #{team2.name} #{game_data['description']}"
  end
end


Then /^I should see the game "([^"]*)" confirmed in the customer agenda$/ do |game_description|
  page.find("div.dhx_cal_event.confirmed", :content => game_description)

end

Then /^the game "([^"]*)" players should receive a reservation ok info for the playground "([^"]*)"$/ do |game_description, playground_name|
  pending # express the regexp above with the code you wish you had
end

Given /^the following confirmed friendly games exist for the playground:$/ do |game_table|
  game_table.hashes.each do |game_data|
    team1 = model(game_data['team1'])
    team2 = model(game_data['team2'])
    date = Chronic.parse(game_data['play_date'])
    playground = Playground.find_by_name(game_data["playground"])
    #playground = model(game_data["playground"])
    data = {:team1 => team1,
           :team2 => team2,
           :play_date => date,
           :playground => playground,
           :description => game_data['description']
           }
    puts "PPPPP>>>> #{data.inspect}"
    game = Factory.create :confirmed_friendly_game, data
    puts "GAme #{game}"
  end
end

When /^I click on the game "([^"]*)" in the agenda$/ do |game_description|
  page.find("div.dhx_cal_event", :content => game_description).click
end

Then /^I should see game "([^"]*)" information on the agenda detail panel$/ do |game_description|
  game = Game.find_by_description game_description
  within "#game_info_panel" do
    page.should have_selector "h3#game_title", :content => "#{game.team1.name} VS #{game.team2.name}"
    page.should have_selector "p#game_description", :content => "#{game_description}"
    within "#game_team1_panel" do
      page.should have_selector "h4[name='team_name']", :content => game.team1.name
      page.should have_selector "li[name='team_player1']", :content => game.team1.player1.name
      page.should have_selector "li[name='team_player2']", :content => game.team1.player2.name
    end
    within "#game_team2_panel" do
      page.should have_selector "h4[name='team_name']", :content => game.team2.name
      page.should have_selector "li[name='team_player1']", :content => game.team2.player1.name
      page.should have_selector "li[name='team_player2']", :content => game.team2.player2.name
    end
  end
end

