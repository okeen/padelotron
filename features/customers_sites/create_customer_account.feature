Feature: Customers create accounts to manage their Playgrounds

  In order to manage my padel playgrounds with Padelotron
  As a Customer
  I want to create a customer account

@javascript
  Scenario: Unknown customer creates an account
        Before do
            Capybara.default_wait_time = 5
        end
        Given I am not logged
        When I go to the customers page
        And I follow "Create an account"
        And I fill in the following:
            | place_name         | Padel Club a Rosa                   |
            | place_full_address | Rua da Rosa 27, Santiago Compostela |
        And I press "Find"
        And I select the first map result
        And I press "Next"

        And I fill in the following:
            | customer_name                  | Name            |
            | customer_surname               | Surname         |
            | customer_email                 | customer1@a.com |
            | customer_password              | aaaaaa          |
            | customer_password_confirmation | aaaaaa          |
        And I press "Submit"
        Then I should see "Your info has been received. We just sent you an email with the confirmation code to activate the account"
        When I press "Ok"
        Then 1 email should be delivered to customer1@a.com
        When I click the first link in the first email
        Then I should see "Welcome Name Surname"

@javascript
  Scenario: Unknown customer tries to create a duplicate email account
        Before do
            Capybara.default_wait_time = 5
        end
        Given a confirmed customer exist with email: "customer1@a.com"
        And I am not logged
        When I go to the customers page
        And I follow "Create an account"
        And I fill in the following:
            | place_name         | Padel Club a Rosa                   |
            | place_full_address | Rua da Rosa 27, Santiago Compostela |
        And I press "Find"
        And I select the first map result
        And I press "Next"

        And I fill in the following:
            | customer_name                  | Name            |
            | customer_surname               | Surname         |
            | customer_email                 | customer1@a.com |
            | customer_password              | aaaaaa          |
            | customer_password_confirmation | aaaaaa          |
        And I press "Submit"
        Then I should see "email has already been taken"
        And I should not see "Welcome Name Surname"
    