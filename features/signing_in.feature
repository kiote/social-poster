
Feature: Signing in

  Scenario: user fails to sign in
    Given user is on the signin page
    When user's input is incorrect
    Then show that its error

  Scenario: signing in
    Given user is on the signin' page
    And there's account already
    When user submit email & password
    Then user's page is visible
    And it's avaliable to click signout
