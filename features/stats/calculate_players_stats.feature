Feature: Track and player's game stats confirmating the result of a game

  In order track the historic of games won/lost and other usefull info about me and my teams
  As a Player and team member
  I want to know the games I've played, how many victories, losses, etc

  Background: Existing players "player1/1a@a.com", "player2/2@a.com", "player3/3@a.com" and "player4/4@a.com",
  existing confirmed team "team1" and "team2", existing confirmed game results:
    Given 4 players exist
    And the following confirmed teams exist:
        |name | player1        | player2        |
        |team1| the 1st player | the 2nd player |
        |team2| the 3rd player | the 4th player |
        |team3| the 1st player | the 3rd player |
        |team4| the 2nd player | the 4th player |

    And the following games already played:
        |desc | team1 | team2 | set1 | set2 | set3 |
        |game1| team1 | team2 |  6-1 | 4-6  |  6-2 |
        |game2| team3 | team4 |  6-4 | 4-6  |  6-1 |
        |game3| team1 | team2 |  0-6 | 6-1  |  4-6 |

    And the following confirmed friendly games exist:
        | description | team1        | team2        | play_date |
        | game4       | the 1st team | the 2nd team | 2011-8-10 |
        | game5       | the 3rd team | the 4th team | 2011-8-10 |

        
  Scenario Outline: Calculate Game stats for players the following Games played between teams:
    Given a result of "<result_sets>" for the game "<desc>"
    When I go to <player1>'s page
    Then I should see "Ganados: <player1_won>"
    And I should see "Perdidos: <player1_lost>"

    When I go to <player2>'s page
    Then I should see "Ganados: <player2_won>"
    And I should see "Perdidos: <player2_lost>"

    When I go to <player3>'s page
    Then I should see "Ganados: <player3_won>"
    And I should see "Perdidos: <player3_lost>"

    When I go to <player4>'s page
    Then I should see "Ganados: <player4_won>"
    And I should see "Perdidos: <player4_lost>"

    #Current score win/lost: Player1 => 2/1; Player2 => 1/2; Player3 => 2/1; Player4 => 1/2 ;

  Scenarios: Victories of Game4 => 1, Game5 => 2, Game3 => 2, Game3 => 1,
        | desc  | result_sets  | player1_won | player1_lost | player2_won | player2_lost | player3_won | player3_lost | player4_won | player4_lost | player1        | player2        | player3        | player4        |
        | game4 | 6-1/4-6/6-2  | 3           | 1            | 2           | 2            | 2           | 2            | 1           | 3            | the 1st player | the 2nd player | the 3rd player | the 4th player |
        | game5 | 6-1/4-6/6-2  | 3           | 1            | 1           | 3            | 3           | 1            | 1           | 3            | the 1st player | the 2nd player | the 3rd player | the 4th player |

  Scenarios: Victories of Game4 => 4, Game5 => 3, Game3 => 4, Game3 => 4,
        | desc  | result_sets  | player1_won | player1_lost | player2_won | player2_lost | player3_won | player3_lost | player4_won | player4_lost | player1        | player2        | player3        | player4        |
        | game4 | 6-1/4-6/2-6  | 2           | 2            | 1           | 3            | 3           | 1            | 2           | 2            | the 1st player | the 2nd player | the 3rd player | the 4th player |
        | game5 | 6-1/4-6/2-6  | 2           | 2            | 2           | 2            | 2           | 2            | 2           | 2            | the 1st player | the 2nd player | the 3rd player | the 4th player |

  Scenarios: Victories of Game4 => 1, Game5 => 3, Game3 => 2, Game3 => 4,
        | desc  | result_sets  | player1_won | player1_lost | player2_won | player2_lost | player3_won | player3_lost | player4_won | player4_lost | player1        | player2        | player3        | player4        |
        | game4 | 6-1/4-6/6-2  | 3           | 1            | 2           | 2            | 2           | 2            | 1           | 3            | the 1st player | the 2nd player | the 3rd player | the 4th player |
        | game5 | 6-1/4-6/2-6  | 2           | 2            | 2           | 2            | 2           | 2            | 2           | 2            | the 1st player | the 2nd player | the 3rd player | the 4th player |
