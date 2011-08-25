
When /^I select the first map result$/ do
  within "ul#geocoded_results" do
    page.find("li.geocoded_place a").click
  end

end

Then /^I should be the free subscription type purchase page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^we should have '(\d+.\d+)' total earnings from #{capture_model}'s subscriptions$/ do |our_money, customer_ref|
  customer = model(customer_ref)
  customer.subscriptions.collect(&:total_revenue).sum.should == our_money.to_f
end
