
Feature: Testing models

  Scenario: create new user
    When create new user
    Then saved
  
  Scenario: update info for user
    Given create new user
    Then update info
    Then not update incorrect info
