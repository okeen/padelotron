Feature: Team Open Graph metadata inclussion and social features

  In order to easily share favourite teams with my friends,
  As a user
  I want to share my favourite teams through Facebook with my friends
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

@javascript
@buggy_test
  Scenario: Player 4 likes the team "team1" and Player 1 sees that after
    When I login as the 4th player
    And I go to the first team's page
    Then I should see "team1"
    And I should see a like button for team with name "team1"
    When I press the like button of team with name "team1"
    Then I should see "You like this"

  Scenario: Include Open Graph metadata for the team in the page headers
    When I go to the first team's page
    Then the page should have the meta attribute "og:title" with value "team1"
    And the page should have the meta attribute "og:type" with value "sports_team"
    And the page should have the meta attribute "og:url" with value "/teams/1"
    And the page should have the meta attribute "og:site_name" with value "Padelotron"
    And the page should have the meta attribute "og:description" with value "team1 page at Padelotron"
