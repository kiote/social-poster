
@send_messages
Feature: sending messages to networks

  In order to make messages to be sent
  I want this tests to prove that they are
  
  @facebook
  Scenario: Sending to Facebook
    Given user
    And user is signed in
    And user is authorised on Facebook
    And there is Home page
    And there is a message to Facebook
    When user click to post a message
    Then successfully sent to Facebook
  
  @linkedin
  Scenario: Sending to Linkedin
    Given user
    And user is signed in
    And user is authorised on Linkedin
    And there is Home page
    And there is a message to Linkedin
    When user click to post a message
    Then successfully sent to Linkedin
  
  @tumblr
  Scenario: Sending to Tumblr
    Given user
    And user is signed in
    And user is authorised on Tumblr
    And there is Home page
    And there is a message to Tumblr
    When user click to post a message
    Then successfully sent to Tumblr
  
  @twitter
  Scenario: Sending to Twitter
    Given user
    And user is signed in
    And user is authorised on Twitter
    And there is Home page
    And there is a message to Twitter
    When user click to post a message
    Then successfully sent to Twitter
  
  @vkontakte
  Scenario: Sending to Vkontakte
    Given user
    And user is signed in
    And user is authorised on Vkontakte
    And there is Home page
    And there is a message to Vkontakte
    When user click to post a message
    Then successfully sent to Vkontakte
