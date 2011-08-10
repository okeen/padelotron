Feature: Set friendly game result

  In order track the historic of games won/lost and piss off my rivals
  As a Player and team member
  I want to save game results

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com",
  existing confirmed team "team1" and "team2", existing confirmed game between "team1" and "team2" for today
    Given 4 players exist
    And the following teams exist:
        |name | player1        | player2        |
        |team1| the 1st player | the 2nd player |
        |team2| the 1st player | the 3rd player |
        |team3| the 2nd player | the 3rd player |

    When I confirm the team "team1"
    And I confirm the team "team2"
    Given an existing and confirmed friendly game "game1" between "team1" and "team2" for today

@wip
  Scenario: Store a result for one game played
    When I go to the games page
    And I click on the game "game1" between "team1" and "team2" for today
    Then I should see "Friendly game between team1 and team2"
    And I should see today at "00":"00" as game play date
    When I press "Set the result"
    Then I should see "Please set the result of the game"
    When I enter "6"-"4" as game result
    And I press "Send the result"
    Then I should see "Game result sent, an email has been sent to all the players to confirm the result"
    