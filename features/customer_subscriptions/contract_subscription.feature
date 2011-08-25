Feature: Customers subscription hiring
  In order to show everybody my advances playing padel games
  As a Player
  I want to get the basic achievements and show them to my friends

@javascript
Scenario Outline: Confirmed Customer logs in and selects plan type
    After
        Chargify::Customer.all.each do |c|
            c.subscriptions.each {|s| s.cancel}
            c.delete
        end
    end

    Given 3 confirmed customers exist
    When I login as <customer>
    And I go to <customer>'s page
    Then I should see "Select your plan type"
    When I follow the "<subscription>" subscription link
    Then I should be on the "<subscription>" subscription type purchase page
    When I fill in the following:
        | Card Number         |     1   |
        | CVV                 | 012     |
        | First Name on Card  | player  |
        | Last Name on Card   | 1       |
        | Address 1           | address |
        | Billing ZIP Code    | 23456   |
        | Billing City        | Lalin   |
    And I select "Albania" from "Billing Country"
    And I select "BR - Berat" from "Billing State"
    And I select "2 - Feb" from "subscription_payment_profile_attributes_expiration_month"
    And I select "2012" from "subscription_payment_profile_attributes_expiration_year"
    And I press "Place My Order"
    Then I should see "Subscription <subscription> was successfully created"
    And we should have '<earnings>' total earnings from <customer>'s subscriptions
    And we should have '<total>' total earnings from all the subscriptions

@javascript
Scenarios: Confirmed Customer logs in and select the plan type
    | subscription | earnings | customer         | total  |
    | free         | 0.0      | the 1st customer | 0.0    |
    | premium      | 7.95     | the 2nd customer | 7.95   |
    | platinum     | 19.95    | the 3rd customer | 19.95  |


    