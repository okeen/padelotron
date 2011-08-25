
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
  puts "   \n#{page.find("a.product", :text => subscription_link_text)['href'].inspect}"
  visit page.find("a.product", :text => subscription_link_text)['href']
end

