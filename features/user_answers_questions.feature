Feature: a quiz

  Background:
    Given the quiz is configured with the questions:
      """
      [
        {"key": "foo", "question": "1+1", "answer": "2", "reference-url": "foo.html"},
        {"key": "bar", "question": "1x3", "answer": "3", "reference-url": "bar.html"}
      ]
      """
    And the quiz has the ending:
      """
      {
        "key": "mission-complete", 
        "reference-url": "mission-complete.html",
        "code": "ABC123", 
        "email": "minisculus@edendevelopment.co.uk"
      }
      """

  Scenario: starting the quiz
    When I GET /start with request headers: 
      """ 
      Accept: application/json 
      """ 
    Then the headers should contain:
      """
      Location: /foo
      """
    And the status should be 303

  Scenario: requesting a question 
    When I GET /foo with request headers:
      """
      Accept: application/json
      """
    Then the body should contain JSON:
      """
      {
        "question": "1+1",
        "reference-url": "/foo.html"
      }
      """
    And the status should be 200

  Scenario: answering a question incorrectly
    Given I have the answer data
      """
      {
        "answer": "3"
      }
      """
    When I PUT /foo with request headers:
      """
      Accept: application/json
      Content-type: application/json
      """
    Then the status should be 406

  Scenario: answering a question correctly
    Given I have the answer data
      """
      {
        "answer": "2"
      }
      """
    When I PUT /foo with request headers:
      """
      Accept: application/json
      """
    Then the headers should contain:
      """
      Location: /bar
      """
    And the status should be 303

  Scenario: requesting another question 
    When I GET /bar with request headers:
      """
      Accept: application/json
      """
    Then the body should contain JSON:
      """
      {
        "question": "1x3",
        "reference-url": "/bar.html"
      }
      """
    And the status should be 200

  Scenario: answering the final question
    Given I have the answer data
      """
      {
        "answer": "3"
      }
      """
    When I PUT /bar with request headers:
      """
      Accept: application/json
      """
    Then the headers should contain:
      """
      Location: /finish/mission-complete
      """
    And the status should be 303

  Scenario: requesting the ending with the correct key
    When I GET /finish/mission-complete with request headers:
      """
      Accept: application/json
      """
    Then the body should contain JSON:
      """
      {
        "code": "ABC123",
        "email": "minisculus@edendevelopment.co.uk",
        "reference-url": "/finish/mission-complete.html"
      }
      """
    And the status should be 200

  Scenario: requesting the ending with the incorrect key
    When I GET /finish/i-have-finished with request headers:
      """
      Accept: application/json
      """
    Then the status should be 406
