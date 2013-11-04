
@sign_in
Feature: Signing in

  Scenario: user fails to sign in
    Given user is on the signin page
    And user have account
    When user's input is incorrect
    Then show that its error
  
  @successful
  Scenario: signing in
    Given user is on the signin page
    And user have account
    When user submit email & password
    Then user's page is visible
    And it's avaliable to click signout
