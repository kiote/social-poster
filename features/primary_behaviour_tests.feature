
Feature: testing users behaviour

  Scenario: main page ; sign in
    Given user is on the main page
    When user click sign in
    Then user view sign_in page
  
  Scenario: main page ; sign up
    Given user is on the main page
    When user click sign up
    Then user view sign_up page, whooa!
  
  Scenario: signing in; okay
    Given user is on the sign in page
    When fields Email, Password correctly filled and sign in pressed
    Then user can observe users#show page
  
  Scenario: signing in; kayo
    Given user is on the sign in page
    When fields Email, Password incorrectly filled and sign in pressed
    Then user can observe sign_in page
    And error message
  
  Scenario: signing up; okay
    Given user is on the sign up page
    When Name, Email, Password, Confirmation fields correctly filled
    And button Create Account has been pressed
    Then there new user appears
    And his page with show action can be observed
  
  Scenario: signing up; okayn't
    Given user is on the sign up page
    When any of field is filled incorrectly
    And button Create Account has been pressed
    Then user can observe sign_up page again
    And a message containing error description
  
  Scenario: Home page; signed in
    Given user is on the Home page
    And signed in
    Then page contains form_for @message
    
  Scenario: Home page; unsigned
    Given user is on the Home page
    And unsigned
    Then page contains things for welcome
  
  Scenario: Signed in user; view profile
    Given user is on the Home page
    And signed in
    And clicked "view profile"
    Then it just users#show/id action
  
  Scenario: Signed in user; view authorisations
    Given user is on the Home page
    And signed in
    And clicked "view providers"
    Then it just some action for TODO:
  
  Scenario: test for account' settings TODO:
    Given TODO: that is given
    Then TODO: ths is to do
  
