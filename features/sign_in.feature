Feature: Signing in

  Scenario: sign in with incorrect info
    Given user is on the signin page
    And user have account
    When user's input is incorrect
    Then show that its error
  
  Scenario: sign in with correct info
    Given user is on the signin page
    And user have account
    When user submit email & password
    Then user's page is visible
    And it's avaliable to click signout
