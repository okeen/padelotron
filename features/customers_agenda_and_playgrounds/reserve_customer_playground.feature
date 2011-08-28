Feature: Reserve game playground for playrgounds from customers with premium or
  platinum accounts

  In order to manage my padel playgrounds with Padelotron
  As a Player
  I want to reserve my favourite playgrounds and let the customer confirm them

  Background: existing customer with premium account
        Given a customer with premium subscription exists
        And the first customer has the following playgrounds:
            | name         | sport |
            | playground 1 | padel |
            | playground 2 | padel |
        And 2 confirmed teams exist
        And the following confirmed friendly games exist for the playground:
            | description | team1        | team2        | play_date    | playground         |
            | game1       | the 1st team | the 2nd team | today, 18:00 | playground 1 |
@javascript
  Scenario: Player creates new game and asks for playground confirmation, customers confirms via web agenda
        When I login as the first customer
        And I go to the first customer's page
        And I follow "Agenda"
        Then I should see '1' games with confirmation pending with:
            | description | team1        | team2        | play_date      |
            | game1       | the 1st team | the 2nd team | today, 18:00|
        When I click on the game "game1" in the agenda
        Then I should see game "game1" information on the agenda detail panel
        And I press "Confirm"
        And the game "game1" players should receive a reservation "confirmation" info for the playground "playground 1"
        And I should see the game "game1" "confirmed" in the customer agenda

@javascript
  Scenario: Player creates new game and asks for playground confirmation, customers rejects via web agenda
        When I login as the first customer
        And I go to the first customer's page
        And I follow "Agenda"
        Then I should see '1' games with confirmation pending with:
            | description | team1        | team2        | play_date      |
            | game1       | the 1st team | the 2nd team | today, 18:00|
        When I click on the game "game1" in the agenda
        Then I should see game "game1" information on the agenda detail panel
        And I press "Reject"
        Then the game "game1" players should receive a reservation "rejection" info for the playground "playground 1"
        And I should see the game "game1" "cancelled" in the customer agenda

@javascript
Scenario: Player creates new game and asks for playground confirmation, customers accepts via email
        When I login as the first customer
        Then the first customer should receive a reserve request for the playground "playground 1" for the game "game1"
        When the first customer clicks on the "confirm" link of the received playground reserve request email
        Then I should see "Playground: playground 1"
        And I should see "Game: game1"
        And I should see "Are you sure you want to confirm the reserve?"
        When I press "Yes"
        Then I should see "Reservation Confirmed"
        And the game "game1" players should receive a reservation "confirmation" info for the playground "playground 1"

@javascript
Scenario: Player creates new game and asks for playground confirmation, customers rejects via email
        When I login as the first customer
        Then the first customer should receive a reserve request for the playground "playground 1" for the game "game1"
        When the first customer clicks on the "reject" link of the received playground reserve request email
        Then I should see "Playground: playground 1"
        And I should see "Game: game1"
        And I should see "Are you sure you want to confirm the reserve?"
        When I press "Yes"
        Then I should see "Reservation Rejected"
        And the game "game1" players should receive a reservation "rejection" info for the playground "playground 1"


