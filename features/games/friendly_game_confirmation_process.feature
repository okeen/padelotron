Feature: Friendly game confirmation ask for other team

  In order play friendly games againt my rivals
  As a Player
  I want to confirm I want (or reject) to play a game at some time against some other rival

  Background:Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com", existing confirmed team "team1" and "team2" and friendly game creation started between "team1" and "team2" for today
    Given 4 players exist
    And the following teams exist:
        |name | player1        | player2        |
        |team1| the 1st player | the 2nd player |
        |team2| the 3st player | the 4rd player |
        |team3| the 2nd player | the 3rd player |

    When I confirm the team "team1"
    And I confirm the team "team2"
    Given a friendly game "game1" creation process between "team1" and "team2" for today initiated by "team1"

Scenario: Click on friendly game confirmation email's OK button to confirm friendly game
    When the 3rd player clicks in the "Confirm" button of the received friendly confirmation email
    Then I should see "Are you sure you want to confirm the friendly game against team1?"
    When I press "Yes"
    Then I should see "You confirmed a game against team1"
    And the 1st player should receive a friendly game against "team2" confirmation email
    And the 2nd player should receive a friendly game against "team2" confirmation email
    And the 3st player should receive a friendly game against "team1" confirmation email
    And the 4nd player should receive a friendly game against "team1" confirmation email

 Scenario: Click on friendly game confirmation email's Reject button to reject membership
    When the 3rd player clicks in the "Reject" button of the received friendly confirmation email
    Then I should see "Are you sure you want to reject the friendly game against team1?"
    When I press "Yes"
    Then I should see "You rejected playing a game against team1"
    And the 1st player should receive a friendly game against "team2" cancellation email
    And the 2nd player should receive a friendly game against "team2" cancellation email
    And the 3st player should receive a friendly game against "team1" cancellation email
    And the 4nd player should receive a friendly game against "team1" cancellation email

