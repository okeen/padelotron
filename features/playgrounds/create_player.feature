Feature: New Playground / Place creation

  In order to know where I play and tell my team mates
  As a Player
  I want to associate a playground to the games I create

  Background: Existing player "player1" with email "player1@a.com"
    Given 4 players exist
    And the following confirmed teams exist:
        |name | player1        | player2        |
        |team1| the 1st player | the 2nd player |
        |team2| the 3rd player | the 4th player |

@todo
  Scenario: Create a new player with name "El lider" and email "leader@coremain.es"
    When I go to the new place page
    And I enter "Pista de Coremain" as place name
    And I select "1" as number of playgrounds
    And I enter "Rúa de Amio 127, Santiago Compostela" as place addess
    And I press "Search addess"
    And I press "Create places"
    Then I should see "Place created."

