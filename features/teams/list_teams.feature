Feature: Team listing

  In order play against other people
  As a Player
  I want to view all available teams and see their info

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com", existing confirmed team "team1" and still to confirm "team2"
    Given 4 players exist
    And the following teams exist:
        |name | player1        | player2        |
        |team1| the 1st player | the 2nd player |
        |team2| the 1st player | the 3rd player |
        |team3| the 2nd player | the 3rd player |

    When I confirm the team "team1"
    And I confirm the team "team2"

@buggy_test
  Scenario: List all the confirmed teams
    When I go to the teams page
    Then I should see '2' teams listed
    And I should see team "team1" basic info with "player1" and "player2"
    And I should see team "team2" basic info with "player1" and "player3"
    And I should not see team "team3" basic info

@todo
  Scenario: Show the available teams to play a game today
    Given the following teams exist:
        |name | player1        | player2        |
        |team4| the 3rd player | the 4th player |
    When I confirm the team "team4"

    Given the following games exist:
        |description | team1        | team2        | play_date          |
        |game1       | the 1st team | the 2nd team | 01 Feb 2011, 17:30 |

    When I confirm the game "game1"
    When I go to the teams page
    And I follow "Show available teams for today"
    Then I should see '1' teams listed
    And I should see team "team4" basic info with "player1" and "player2"
    And I should not see team "team1" basic info
    And I should not see team "team2" basic info
    And I should not see team "team3" basic info

