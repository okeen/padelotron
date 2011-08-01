Feature: New friendly game creation

  In order play a game against some other teams
  As a Player and team member
  I want to create a friendly game against other teams to play in some available date

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com", existing confirmed team "team1" and "team2"
    Given an existing player "player1" with email "1@a.com"
    Given an existing player "player2" with email "2@a.com"
    Given an existing player "player3" with email "3@a.com"
    Given an existing player "player4" with email "4@a.com"
    Given an existing and confirmed team "team1" for "player1" and "player2"
    Given an existing and confirmed team "team2" for "player3" and "player4"

  Scenario: Create a friendly game through the new friendly game page
    When I go to the new friendly game page
    And I select "team1" as first team
    And I select "team2" as second team
    And I select '12'/"August"/'2011', '17':'00' as play date
    And I press "Create Friendly"
    Then I should see "Friendly game creation process initialized, an email has been send to team2 to confirm the game."
    And "3@a.com" should receive a friendly game offer from "team1" for '12'/'08'/'2011', '17':'00' 


