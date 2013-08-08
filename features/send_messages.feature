
Feature: Post messages

  In order to make messages to be sent
  I want this tests to prove that they are
  
  @post_message_linkedin
  Scenario: Sending to Linkedin
    Given user
    And user is signed in
    And user is authorised for linkedin
    And there is Home page
    And there is a message to Linkedin
    When user click to post a message
    Then there is a message that message is sent okay
