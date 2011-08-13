Feature: New friendly game creation

  In order play a game against some other teams
  As a Player and team member
  I want to create a friendly game against other teams to play in some available date

  Background: Existing players "player1/1a@a.com", "player2/2@a.com" and "player3/3@a.com",
    existing confirmed team "team1" and "team2"
    Given 4 players exist
    And the following teams exist:
        |name | player1        | player2        |
        |team1| the 1st player | the 2nd player |
        |team2| the 3st player | the 4rd player |
        |team3| the 2nd player | the 3rd player |

    When I confirm the team "team1"
    And I confirm the team "team2"
    And I login as the first player

@wip
  Scenario: Create a friendly game through the new friendly game page
    When I go to the new friendly game page
    And I select the first team as first team
    And I select the 2nd team as second team
    And I select '12'/"August"/'2011', '17':'00' as play date
    And I press "Create Friendly"
    Then I should see "Friendly game creation process initialized, an email has been send to team2 to confirm the game."
    And the 3rd player should receive a friendly game offer from the 1st team for '12'/'08'/'2011', '17':'00'
    And the 4th player should receive a friendly game offer from the 1st team for '12'/'08'/'2011', '17':'00'


