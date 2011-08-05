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
        |team2| the 1st player | the 3rd player |
        |team3| the 2nd player | the 3rd player |

    When I confirm the team "team1"
    And I confirm the team "team2"
    Given the following games exist:
        |description | team1        | team2        | play_date          |
        |game1       | the 1st team | the 2nd team | 01 Feb 2011, 17:30 |
        |game2       | the 1st team | the 3rd team | 02 Feb 2011, 14:30 |

    When I confirm the game "game1"


@todo
 Scenario: Click on game result confirmation email's OK button to confirm friendly game
    When "player3" clicks in the "Confirm" button of the received friendly confirmation email
    Then I should see "Are you sure you want to confirm the friendly game against team1?"
    When I press "Yes"
    Then I should see "You confirmed a game against team1"
    And "1@a.com" and "2@a.com" should receive a friendly game against "team2" confirmation email
    And "3@a.com" and "4@a.com" should receive a friendly game against "team1" confirmation email

@todo
  Scenario: Click on game result confirmation email's Reject button to reject membership
    When I click in the "Reject" button of the received email
    Then I should see "Are you sure you want to reject the friendly game against team1?"
    When I press "Yes"
    Then I should see "You rejected playing a game against team1"
    And "1@a.com" and "2@a.com" should receive a friendly game against "team2" cancellation email
    And "3@a.com" and "4@a.com" should receive a friendly game against "team1" cancellation email

