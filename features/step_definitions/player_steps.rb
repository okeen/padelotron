

When /^I enter "([^"]*)" as username and "([^"]*)" as email$/ do |name, email|
  within "form#new_player" do
    fill_in :name, :with => name
    fill_in :email, :with => email    
  end
end