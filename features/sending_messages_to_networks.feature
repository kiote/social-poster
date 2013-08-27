
@send_messages
Feature: sending messages to networks

  In order to make messages to be sent
  I want this tests to prove that they are
  
  @facebook
  Scenario: Sending to Facebook
    Given user
    And user is signed in
    And user is authorised for facebook
    And there is Home page
    And there is a message to Facebook
    When user click to post a message
    Then sent to facebook okay
  
  @linkedin
  Scenario: Sending to Linkedin
    Given user
    And user is signed in
    And user is authorised for linkedin
    And there is Home page
    And there is a message to Linkedin
    When user click to post a message
    Then sent to linkedin okay
  
  @tumblr
  Scenario: Sending to Tumblr
    Given user
    And user is signed in
    And user is authorised for Tumblr
    And there is Home page
    And there is a message to Tumblr
    When user click to post a message
    Then successfully sent to tumblr
  
  @twitter
  Scenario: Sending to Twitter
    Given user
    And user is signed in
    And user is authorised for Twitter
    And there is Home page
    And there is a message to Twitter
    When user click to post a message
    Then sent to twitter okay
  
  @vkontakte
  Scenario: Sending to Vkontakte
    Given user
    And user is signed in
    And user is authorised for vkontakte
    And there is Home page
    And there is a message to Vkontakte
    When user click to post a message
    Then sent to vkontakte okay
