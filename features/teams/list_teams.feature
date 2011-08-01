Feature: Team listing

  In order play against other people
  As a Player
  I want to view all available teams and see their info

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com", existing confirmed team "team1" and still to confirm "team2"
    Given an existing player "player1" with email "1@a.com"
    Given an existing player "player2" with email "2@a.com"
    Given an existing player "player3" with email "3@a.com"
    Given an existing player "player4" with email "4@a.com"
    Given an existing and confirmed team "team1" for "player1" and "player2"
    Given an existing and confirmed team "team2" for "player1" and "player3"
    And a "team3" team creation process for "player2" and "player3" initiated by "player3"

@wip
  Scenario: List all the confirmed teams
    When I go to the teams index page
    Then I should see '2' teams listed
    And I should see team "team1" basic info with "player1" and "player2"
    And I should see team "team2" basic info with "player1" and "player3"
    And I should not see team "team3" basic info

   Scenario: Show the available teams to play a game today
    Given an existing and confirmed team "team4" for "player3" and "player4"
    Given an existing and confirmed friendly game between "team1" and "team2" for today
    When I click on "Show available teams for today"
    Then I should see '1' team listed
    And I should see team "team4" basic info with "player1" and "player2"
    And I should not see team "team1" basic info
    And I should not see team "team2" basic info
    And I should not see team "team3" basic info

