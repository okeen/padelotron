Feature: Game Open Graph metadata inclussion and social features

  In order to easily share game offers and results and contact my friends,
  As a user
  I want to share my favourite games through Facebook with my friends
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

    When I confirm the team "team1"
    And I confirm the team "team2"
    And I confirm the team "team3"
    Given the following games exist:
        |description | team1        | team2        | play_date          |
        |game1       | the 1st team | the 2nd team | 01 Feb 2011, 17:30 |
        |game2       | the 1st team | the 3rd team | 02 Feb 2011, 14:30 |

    When I confirm the game "game1"

@buggy_test
@javascript
  Scenario: Player 4 likes the game "game1" and Player 1 sees that after
    When I login as the 4th player
    And I go to the games page
    Then I should see the game "game1" between "team1" and "team2" for today at "00":"00"
    When I click on the game "game1" between "team1" and "team2" for today
    Then I should see "Friendly game between team1 and team2"
    And I should see a like button for the game "game1"
    When I press the like button of the game "game1"
    Then I should see "You like this"

  Scenario: Include Open Graph metadata for the game in the page headers
    When I go to the games page
    Then I should see the game "game1" between "team1" and "team2" for today at "00":"00"
    When I click on the game "game1" between "team1" and "team2" for today
    Then I should see "Friendly game between team1 and team2"
    And the page should have the meta attribute "og:title" with value "game1"
    And the page should have the meta attribute "og:type" with value "sports_game"
    And the page should have the meta attribute "og:url" with value "/games/1"
    And the page should have the meta attribute "og:site_name" with value "Padelotron"
    And the page should have the meta attribute "og:description" with value "game1 page at Padelotron"
