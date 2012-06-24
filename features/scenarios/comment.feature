@javascript
Feature: In order to see  comments on the answers and questions
  I as a user
  can comment answers and questions

  Background:
    Given a user "r2d2" exists with name: "r2d2", email: "r2d2@r.com"
    And a question "question1" exists with subject: "Euro", description: "description", user: user "r2d2"
    And a question "question2" exists with subject: "Alien", description: "2"
    And a answer "answer1" exists with question: question "question1", user: user "r2d2"
    And I sign in as user with "r2d2@r.com"

  Scenario: User can comment answer
    When I follow "Euro"
    And I press "Add comment"
    And I fill in
