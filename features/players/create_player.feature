Feature: New player creation

  In order start managing real world padel games
  As a Player
  I want to create a new player in the system with my real name

  Background: Player is an existing Coremain worker.


  Scenario: Create a new player with name "El lider" and email "leader@coremain.es"
    When I go to the new player page
    And I enter "El lider" as username and "leader@coremain.es" as email
    And I press "Create Player"
    Then I should see "Player created."

