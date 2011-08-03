Feature: Game listing

  In order to know what games the people have played
  As a Player
  I want to view all available games

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com",
  existing confirmed team "team1" and still to confirm "team2", existing confirmed game between "team1" and "team2" for today
    Given an existing player "player1" with email "1@a.com"
    And an existing player "player2" with email "2@a.com"
    And an existing player "player3" with email "3@a.com"
    And an existing player "player4" with email "4@a.com"
    And an existing and confirmed team "team1" for "player1" and "player2"
    And an existing and confirmed team "team2" for "player1" and "player3"
    And an existing and confirmed game "game1" between "team1" and "team2" for today
    And a friendly game "game1" creation process between "team1" and "team2" for today initiated by "team2"

@todo
  Scenario: List all the confirmed games
    When I go to the games index page
    Then I should see '1' games listed
    And I should see the game "game1" between "team1" and "team2" for today at "00":"00"

@todo
   Scenario: Show details of a game between "team1" and "team2"
    When I go to the teams index page
    And I click on the game "game1" between "team1" and "team2" for today
    Then I should see "Friendly game between team1 and team2"
    And I should see today at "00":"00" as game play date
    
    