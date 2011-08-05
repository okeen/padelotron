Feature: Game listing

  In order to know what games the people have played
  As a Player
  I want to view all available games

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com",
  existing confirmed team "team1","team2", "team3", existing confirmed game between "team1" and "team2" for today
    Given 4 players exist
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


  Scenario: List all the confirmed games
    When I go to the games page
    Then I should see '1' games listed
    And I should see the game "game1" between "team1" and "team2" for today at "00":"00"

  Scenario: Show details of a game between "team1" and "team2"
    When I go to the games page
    Then I should see the game "game1" between "team1" and "team2" for today at "00":"00"
    When I click on the game "game1" between "team1" and "team2" for today
    Then I should see "Friendly game between team1 and team2"
    And I should see today at "00":"00" as game play date
    
    