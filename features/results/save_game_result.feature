Feature: Set friendly game result

  In order track the historic of games won/lost and piss off my rivals
  As a Player and team member
  I want to save game results

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com",
  existing confirmed team "team1" and "team2", existing confirmed game between "team1" and "team2" for today
    Given an existing player "player1" with email "1@a.com"
    Given an existing player "player2" with email "2@a.com"
    Given an existing player "player3" with email "3@a.com"
    Given an existing player "player4" with email "4@a.com"
    Given an existing and confirmed team "team1" for "player1" and "player2"
    Given an existing and confirmed team "team2" for "player3" and "player4"
    Given an existing and confirmed game "game1" between "team1" and "team2" for today

@todo
  Scenario: Store a result for one game played
    When I go to the games index page
    And I click on the game "game1" between "team1" and "team2" for today
    Then I should see "Friendly game between team1 and team2"
    And I should see today at "00":"00" as game play date
    When I press "Set the result"
    Then I should see "Please set the result of the game"
    When I enter "20"-"12" as game result
    And I press "Send the result"
    Then I should see "Game result sent, an email has been sent to all the players to confirm the result"
    