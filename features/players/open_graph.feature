Feature: Player Open Graph metadata inclussion and social features

  In order to easily share favourite and friend players and contact my friends,
  As a user
  I want to share my favourite players through Facebook with my friends
  and interact with my friends activity.

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com",
  existing confirmed team "team1","team2", "team3", existing confirmed game between "team1" and "team2" for today
    Given the date is "01 February 2011"
    And 4 players exist
    And the following teams exist:
        |name | player1        | player2        |
        |team1| the 1st player | the 2nd player |
        |team2| the 3st player | the 4rd player |
        |team3| the 2nd player | the 3rd player |

@buggy_test
@javascript
  Scenario: Player 4 likes Player 1's page
    When I login as the 4th player
    And I go to the 1st player's page
    Then I should see the 1st player's name
    And I should see the 1st player's photo
    And I should see a like button for the first player
    When I press the like button of the first player
    Then I should see "You like this"

  Scenario: Include Open Graph metadata for the player in the page headers
     Given the following players exist:
        |name   | email         |
        |player5| player5@a.com |
    When I go to the 5th player's page
    Then the page should have the meta attribute "og:title" with value "player5"
    And the page should have the meta attribute "og:type" with value "athlete"
    And the page should have the meta attribute "og:url" with value "/players/5"
    And the page should have the meta attribute "og:site_name" with value "Padelotron"
    And the page should have the meta attribute "og:description" with value "player5 page at Padelotron"
