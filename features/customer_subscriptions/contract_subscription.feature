Feature: Customers subscription hiring
  In order to show everybody my advances playing padel games
  As a Player
  I want to get the basic achievements and show them to my friends

@wip
@javascript
Scenario: Confirmed Customer logs in and select the basic plan type
    Given a confirmed customer exists
    When I login as the first customer
    And I go to the first confirmed customer's page
    Then I should see "Select your plan type"
    When I follow "Free"
    Then I should be on the "free" subscription type purchase page
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
    Then I should see "Subscription free was successfully created"
    And we should have '0.0' total earnings from the first customer's subscriptions

@javascript
Scenario: Confirmed Customer logs in and select the premium plan type
    Given a confirmed customer exists
    When I login as the first customer
    And I go to the first confirmed customer's page
    Then I should see "Select your plan type"
    When I follow "Premium"
    Then I should be on the "premium" subscription type purchase page
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
    Then I should see "Subscription premium was successfully created"
    And we should have '7.95' total earnings
