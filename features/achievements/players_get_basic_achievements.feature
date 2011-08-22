Feature: Players get achievements after they finish some quest

  In order to show everybody my advances playing padel games
  As a Player
  I want to get the basic achievements and show them to my friends

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
        |game2| team1 | team2 |  6-4 | 4-6  |  6-1 |

    And the following confirmed friendly games exist:
        | description | team1        | team2        | play_date |
        | game4       | the 1st team | the 2nd team | 2011-8-10 |
        | game5       | the 3rd team | the 4th team | 2011-8-10 |
        
@wip
  Scenario: Player 1 and 2 wins 3 games and get a striked achivement
        Given a result of "6-2/2-6/6-2" for the game "game1"
        When I go to the players page
        Then the following players should have these achievements:
            | player             | achievements_count | new_achievement | lost_Achievement | message                                 |
            | the first player   | 1                  |  striked        |  0               |  Good! You got the strike achievement   |
            | the second player  | 1                  |  striked        |  0               |  Good! You got the strike achievement   |
            | the third player   | 1                  |  buzzed         |  0               |  Oh, no! You got the strike achievement |
            | the fourth player  | 1                  |  buzzed         |  0               |  Oh, no! You got the strike achievement |

