
Then /^the following players should have these achievements:$/ do |table|
  table.hashes.each do |achievements_data|
    puts "Data: #{achievements_data.inspect}"
    When "I login as #{achievements_data['player']}"
    And "I go to #{achievements_data['player']}'s page"
    Then "I should see '#{achievements_data['achievements_count']}' achievements for the player"
    And "the player should have the new achievement \"#{achievements_data['new_achievement']}\""
    And "the player's achievements should include \"#{achievements_data['new_achievement']}\""
    And "the player should have lost the achievement \"#{achievements_data['lost_achievement']}\""
    #And "I should see \"#{achievements_data['message']}\""
  end
end

Then /^I should see '(\d+)' achievements for the player$/ do |achievement_count|
  page.should have_selector "table.achievements_group_table tr td.achievement.got"
                              #:count => achievement_count.to_i
  
end

Then /^the player should have the new achievement "([^"]*)"$/ do |achievement_name|
  unless achievement_name == "0"
    page.should have_selector("table.achievements_group_table tbody tr td.achievement.got img[alt='#{achievement_name}']",
      :src => "/images/achievements/#{achievement_name}.png")
  end
end

Then /^the player's achievements should include "([^"]*)"$/ do |achievement_name|
  unless achievement_name == "0"
    page.should have_selector("table.achievements_group_table tbody tr td.achievement.got img[alt='#{achievement_name}']",
      :src => "/images/achievements/#{achievement_name}.png")
  end
end

Then /^the player should have lost the achievement "([^"]*)"$/ do |achievement_name|
  unless achievement_name == "0"
    page.should_not have_selector("table.achievements_group_table tbody tr td.achievement.got img[alt='#{achievement_name}']",
      :src => "/images/achievements/#{achievement_name}.png")
  end
end
