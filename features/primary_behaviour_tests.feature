
Feature: testing users behaviour
  As a project modeller
  I want that project to have proper functionality and correct behaviour
  So that there are couple of tests to pass
  
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
  
  # что за kayo
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
  
  # что за okayn't
  Scenario: signing up; okayn't
    Given user is on the sign up page
    When any of field is filled incorrectly
    And button Create Account has been pressed
    Then user can observe sign_up page again
    And a message containing error description
  
  Scenario: View of home page when user is signed
    Given user
    And user is signed in
    And there is Home page
    Then page contains form_for @message
    
  Scenario: View of home page when user is unsigned
    Given user isnt signed
    And there is Home page
    Then page contains things for welcome
  
  Scenario: viewing profile
    Given user
    And user is signed in
    And there is Home page
    And clicked "view profile"
    Then there is users profile page (users show action)
  
  Scenario: view authorisations
    Given user
    And user is signed in
    And there is Home page
    And clicked "view providers"
    Then there is users providers page (providers show action)
  
  Scenario: viewing settings for user
    Given user
    And user is signed in
    And there is Home page
    And clicked to the settings
    Then there is page for settings
    
