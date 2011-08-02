Feature: Friendly game confirmation ask for other team

  In order play friendly games againt my rivals
  As a Player
  I want to confirm I want (or reject) to play a game at some time against some other rival

  Background:Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com", existing confirmed team "team1" and "team2" and friendly game creation started between "team1" and "team2" for today
    Given an existing player "player1" with email "1@a.com"
    And an existing player "player2" with email "2@a.com"
    And an existing player "player3" with email "3@a.com"
    And an existing player "player4" with email "4@a.com"
    And an existing and confirmed team "team1" for "player1" and "player2"
    And an existing and confirmed team "team2" for "player3" and "player4"
    And a friendly game creation process between "team1" and "team2" for today initiated by "team1"

@wip
 Scenario: Click on friendly game confirmation email's OK button to confirm friendly game
    When "player3" clicks in the "Confirm" button of the received friendly confirmation email
    Then I should see "Are you sure you want to confirm the friendly game against team1?"
    When I press "Yes"
    Then I should see "You confirmed a game against team1"
    And "1@a.com" and "2@a.com" should receive a friendly game against "team2" confirmation email
    And "3@a.com" and "4@a.com" should receive a friendly game against "team1" confirmation email

  Scenario: Click on friendly game confirmation email's Reject button to reject membership
    When I click in the "Reject" button of the received email
    Then I should see "Are you sure you want to reject the friendly game against team1?"
    When I press "Yes"
    Then I should see "You rejected playing a game against team1"
    And "1@a.com" and "2@a.com" should receive a friendly game against "team2" cancellation email
    And "3@a.com" and "4@a.com" should receive a friendly game against "team1" cancellation email

