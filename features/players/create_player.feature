Feature: New player creation

  In order start managing real world padel games
  As a Player
  I want to create a new player in the system with my real name

  Background: Existing player "player1" with email "player1@a.com"
    Given the following players exist:
        |name   | email         |
        |player1| player1@a.com |
    
  Scenario: Create a new player with name "El lider" and email "leader@coremain.es"
    When I go to the new player page
    And I enter "El lider" as username and "leader@coremain.es" as email
    And I press "Create Player"
    Then I should see "Player created."
    And a player should exist with name: "El lider"
    And I should see the recently created player with name "El lider" and email "leader@coremain.es"

  Scenario: Try to create duplicate email player with name "player1" and email "player1@a.com" and show an error
    When I go to the new player page
    And I enter "player1" as username and "player1@a.com" as email
    And I press "Create Player"
    Then I should see "2 errors"
    And I should see "Name has already been taken"
    And I should see "Email has already been taken"


