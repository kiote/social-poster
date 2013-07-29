
Feature: Sending messages

Scenario: user is trying to send twitter message
Given user is signed in and authorised on twitter
And there is root page
When user's input is correct
Then show that messages is sent to twitter
