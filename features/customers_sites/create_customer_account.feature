Feature: Customers create accounts to manage their Playgrounds

  In order to manage my padel playgrounds with Padelotron
  As a Customer
  I want to create a customer account

@wip
  Scenario: Unknown customer creates an account
        Given I am not logged
        When I go to the customers page
        And I follow "Create an account"
        And I fill in "Association Name" with "Padel Club a Rosa"
        And I fill in "Address" with "Rua da Rosa 27, Santiago Compostela"
        And I press "Find"
        And I select the first map result
        And I select "4" from "Number of playgrounds"
        And I press "Next"
        And I fill in "Name" with "Name"
        And I fill in "Surname" with "Name"
        And I fill in "Email" with "Name"
        And I press "Next"
        And I press "free"
        Then I should be the free subscription type purchase page

