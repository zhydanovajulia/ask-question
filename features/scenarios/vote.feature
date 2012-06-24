@javascript
Feature: In order to rate questions and answers
         I as a user
         can vote the questions and answers

  Background:
    Given a user "r2d2" exists with name: "r2d2", email: "r2d2@r.com"
    And a question "question1" exists with subject: "Euro", description: "description", user: user "r2d2"
    And a question "question2" exists with subject: "Alien", description: "2"
    And a question rating "rating2" exists with rateable: question "question2", score: 1
    And a answer "answer1" exists with question: question "question1", user: user "r2d2"
    And I sign in as user with "r2d2@r.com"

  Scenario: User can vote question only one time
    When I follow "Euro"
    When I follow "vote up" within ".question-table .vote-cell"
    Then I should see "1" within question "question1"
    When I follow "vote up" within ".question-table .vote-cell"
    Then I should see "1" within question "question1"
    And I should see "You can vote only one time"

  Scenario: After voting user should see votes +1 on the questions page
    When I follow "Alien"
    And I follow "vote up" within ".question-table .vote-cell"
    And I follow "Questions"
    Then I should see "2" within question "question2"

  Scenario: User can vote answer only one time
    When I follow "Euro"
    And I follow "vote up" within answer "answer1"
    Then I should see "1" within answer "answer1"
    When I follow "vote up" within answer "answer1"
    Then I should see "You can vote only one time"
