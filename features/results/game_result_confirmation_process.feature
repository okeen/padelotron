Feature: Game result confirmation process asking all the members if result is correct

  In order track what games I win and lose
  As a Player
  I want to confirm I want (or reject) the result of a game


  After do
      Timecop.return
  end

  Background: We are on 01 February 2011,
  existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com",
  existing confirmed team "team1" and "team2" and game result confirmation started by "player1"

    Given the date is "01 February 2011"
    Given 4 players exist
    And the following teams exist:
        |name | player1        | player2        |
        |team1| the 1st player | the 2nd player |
        |team2| the 3rd player | the 4th player |
        |team3| the 2nd player | the 3rd player |

    When I confirm the team "team1"
    And I confirm the team "team2"
    And I confirm the team "team3"

    Given the following games exist:
        |description | team1        | team2        | play_date          |
        |game1       | the 1st team | the 2nd team | 01 Feb 2011, 17:30 |
        |game2       | the 1st team | the 3rd team | 02 Feb 2011, 14:30 |

    When I confirm the game "game1"
    Given the following result confirmation process for the game "game1":
        |set_num | team1 | team2 |
        | 1      |  6    | 1     |
        | 2      |  4    | 6     |
        | 3      |  6    | 2     |

 Scenario: Click on game result confirmation email's OK button to confirm the game result
    When the 3rd player clicks in the "Confirm" button of the received game result confirmation email
    Then I should see "Are you sure you want to confirm the result of the game"
    When I press "Yes"
    Then I should see "You confirmed the result of the game game1"
    And the 1st player should receive a game "game1" result confirmation email
    And the 2nd player should receive a game "game1" result confirmation email
    And the 3rd player should receive a game "game1" result confirmation email
    And the 4th player should receive a game "game1" result confirmation email

 Scenario: Click on game result confirmation email's Reject button to reject membership
    When the 3rd player clicks in the "Reject" button of the received game result confirmation email
    Then I should see "Are you sure you want to reject the result of the game game1?"
    When I press "Yes"
    Then I should see "You rejected the result of the game game1"
    And the 1st player should receive a game "game1" result cancellation email
    And the 2nd player should receive a game "game1" result cancellation email
    And the 3rd player should receive a game "game1" result cancellation email
    And the 4th player should receive a game "game1" result cancellation email