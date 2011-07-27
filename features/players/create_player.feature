Feature: New player creation

  In order start managing real world padel games
  As a Player
  I want to create a new player in the system with my real name

  Background: Existing player "player" with email "a@a.com"
    Given an existing player "player" with email "a@a.com"

  Scenario: Create a new player with name "El lider" and email "leader@coremain.es"
    When I go to the new player page
    And I enter "El lider" as username and "leader@coremain.es" as email
    And I press "Create Player"
    Then I should see "Player created."
    And I should see the recently created player with name "El lider" and email "leader@coremain.es"

  Scenario: Try to create duplicate email player with name "player" and email "a@a.com" and show an error
    When I go to the new player page
    And I enter "player" as username and "a@a.com" as email
    And I press "Create Player"
    Then I should see "2 errors"
    And I should see "Name has already been taken"
    And I should see "Email has already been taken"


