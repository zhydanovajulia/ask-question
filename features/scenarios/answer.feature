@javascript
Feature: In order to manage answers
		 I as a user
		 try to create, update and vote answers

  Background:
	Given a user "r2d2" exists with name: "r2d2", email: "r2d2@r.com"
	And a question "question1" exists with subject: "Euro", description: "description", user: user "r2d2"
	And a question "question2" exists with subject: "Alien", description: "2"
  	And I sign in as user with "r2d2@r.com"

  Scenario: User can answer the question
    When I follow "Alien"
    And I fill in "answer[body]" with "new answer"
    And I press "Create Answer"
    Then I should see "1 Answer" within ".answers-head"

  Scenario: User can edit his answer
    When I follow "Alien"
    And I fill in "answer[body]" with "new answer"
    And I press "Create Answer"
    And I follow "Edit"
    And I fill in "answer[body]" with "very new answer"
    And I press "Update Answer"
    Then I should see "very new answer"
    And I wait for 5 seconds