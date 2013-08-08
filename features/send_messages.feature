
Feature: Post messages

  In order to make messages to be sent
  I want this tests to prove that they are
  
  
  Scenario: Sending to Linkedin
    Given user is signed in
    And there is Home page
    And there is a message to Linkedin
    When user click to post a message
    Then there is a message that message is sent okay
