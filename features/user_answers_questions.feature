Feature: a quiz

  @simple_questions
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

  @simple_questions
  Scenario: requesting a question 
    When I GET /foo with request headers:
      """
      Accept: application/json
      """
    Then the body should contain JSON:
      """
      {
        "question": "1+1"
      }
      """
    And the status should be 200


  @simple_questions
  Scenario: answering a question incorrectly
    Given I have the answer data
      """
      {
        "github-repo": "http://github.com/example/project",
        "answer": "3"
      }
      """
    When I PUT /foo with request headers:
      """
      Accept: application/json
      """
    Then the status should be 406

  @simple_questions
  Scenario: answering a question correctly
    Given I have the answer data
      """
      {
        "github-repo": "http://github.com/example/project",
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

  @simple_questions
  Scenario: requesting another question 
    When I GET /bar with request headers:
      """
      Accept: application/json
      """
    Then the body should contain JSON:
      """
      {
        "question": "1x3"
      }
      """
    And the status should be 200

  @simple_questions
  Scenario: answering the final question
    Given I have the answer data
      """
      {
        "github-repo": "http://github.com/example/project",
        "answer": "3"
      }
      """
    When I PUT /bar with request headers:
      """
      Accept: application/json
      """
    Then the headers should contain:
      """
      Location: /you-have-finished
      """
    And the status should be 303
