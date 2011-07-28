Feature: New Team creation

  In order play with my fellows in the same team
  As a Player
  I want to create a new team and add my

  Background: Existing players "player1/1a@a.com" and "player2/2@a.com"
    Given an existing player "player1" with email "1@a.com"
    Given an existing player "player2" with email "2@a.com"

  Scenario: Create a new team named "team1" for "player1" and "player2"
    When I go to the new team page
    And I enter "team1" as team name
    And I select "player1" as first player
    And I select "player2" as team mate
    And I press "Create Team"
    Then I should see "Team creation process opened. An email have been sent to player2 to confirm the team creation"
    And "2@a.com" should receive a "team1" membership ask email from "player1"


