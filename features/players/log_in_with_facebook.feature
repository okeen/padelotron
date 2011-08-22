Feature: Log in with my Facebook account

  In order start managing real world padel games with my friends
  As a Player
  I want to log in with my facebook account

  Before do
      request.env["devise.mapping"] = Devise.mappings[:player]
  end

  Background: Existing facebook user "player1" with password "player1"
    Given a player exist
    And an unconnected player exist

  @buggy_test
  @selenium
  Scenario: Log in with the last players Facebook account and link with Facebook Connect via omniauth
    When I go to the root page
    And I follow "Sign in with Facebook"
    And I enter the first unconnected player 's email as Email
    And I enter the first unconnected player 's password as Password
    And I press "Log In"
    And I press "Allow"
    Then I should see "Kaixo "

@buggy_test
@selenium
 Scenario: Log in with the first connected player's Facebook account and link with Facebook Connect via Facebook Login
    When I go to the root page
    And I press the FB "Log In" button
    And I enter the first player 's email as Email
    And I enter the first player 's password as Password
    And I press "Log In" in Facebook
    Then I should see "Kaixo "

  @buggy_test
  @selenium
  Scenario: Log in with an already facebook-connected "player1"'s Facebook account
    When I go to the root page
    And I follow "Sign in with Facebook"
    And I enter the first player 's email as Email
    And I enter the first player 's password as Password
    And I press "Login"
    Then I should see "Kaixo "
    

