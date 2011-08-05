Feature: New Team creation

  In order play with my fellows in the same team
  As a Player
  I want to create a new team and add my

  Background: Existing players "player1/player1a@a.com" and "player2/player2@a.com"
    Given the following players exist:
        |name   | email         |
        |player1| player1@a.com |
        |player2| player2@a.com |

  Scenario: Create a new team named "team1" for "player1" and "player2"
    When I go to the new team page
    And I enter "team1" as team name
    And I select "player1" as first player
    And I select "player2" as team mate
    And I press "Create Team"
    Then I should see "Team creation process opened. An email have been sent to player2 to confirm the team creation"
    And the 2nd player should receive a "team1" membership ask email from "player1"


