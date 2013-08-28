
@models
Feature: testing models
  
  As a project modeller
  I want models to be modelled correctly
  So that there are few tests to pass
  
  Scenario: message creation
    Given user
    When there attempt to create a message for user
    Then message is created
  
  Scenario: message and submessages creation
    Given user
    When there attempt to create a message for user
    Then message is created
    When there attempt to create a submessages for message
    Then submessages is created
