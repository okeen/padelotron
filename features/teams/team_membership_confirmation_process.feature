Feature: Team membership confirmation ask for other team

  In order play with my fellows in the same team
  As a Player
  I want to confirm I play in the same team that my friend created before

  Background: Existing players "player1/1a@a.com" and "player2/2@a.com" and "team1" team creation process started by "player1"
    Given an existing player "player1" with email "1@a.com"
    And an existing player "player2" with email "2@a.com"
    And a "team1" team creation process for "player1" and "player2" initiated by "player1"


 Scenario: Click on email's confirmation OK button to confirm membership
    When I click in the "Confirm" button of the received email
    Then I should see "Are you sure you want to join team1?"
    When I press "Yes"
    Then I should see "You joined team1"
    And "1@a.com" should receive a "team1" membership confirmation email
    And "2@a.com" should receive a "team1" membership confirmation email

  Scenario: Click on email's confirmation Reject button to reject membership
    When I click in the "Reject" button of the received email
    Then I should see "Are you sure you want to reject joining team1?"
    When I press "Yes"
    Then I should see "You rejected joining team1"
    And "1@a.com" should receive a "team1" team cancelation email
    And "2@a.com" should receive a "team1" team cancelation email

