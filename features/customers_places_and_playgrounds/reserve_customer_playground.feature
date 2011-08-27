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
        And the following confirmed friendly games exist:
            | description | team1        | team2        | play_date    | playground         |
            | game1       | the 1st team | the 2nd team | today, 18:00 | the 2nd playground |



@wip
@javascript
  Scenario: Player creates new game and asks for playground confirmation
        When I login as the first customer
        And I go to the first customer's page
        And I follow "Agenda"
        Then I should see '1' games with confirmation pending with:
            | description | team1        | team2        | play_date      |
            | game1       | the 1st team | the 2nd team | today, 18:00|
        When I press "Confirm"
        Then I should see the game "game1" confirmed in the customer agenda
        And the game "game1" players should receive a reservation ok info for the playground "playground 1"
