@javascript
Feature: In order to manage questions
		 I as a user
		 try to create, update and vote questions

Background:
	Given a user "r2d2" exists with name: "r2d2", email: "r2d2@r.com"
	And a question "question1" exists with subject: "Euro", description: "description", user: user "r2d2"
	And a question "question2" exists with subject: "Alien", description: "2"
	And a question rating "rating2" exists with question: question "question2", score: 1
  	And I sign in as user with "r2d2@r.com"

Scenario: User can create new question
	When I follow "Ask question"
	And I fill in the following:
	| Subject 	  | new question |
	| Description | description  |
	And I press "Create Question"
	Then I should see "Question was created"
	And I should see "new question" within ".subject"

Scenario: User can edit his question
	When I follow "Edit" within question "question1"
	And I fill in "Description" with "not bad"
	And I press "Update Question"
	Then I should see "Question was updated"

Scenario: User can't edit not owned him questions
	Then I should not see "Edit" within question "question2"

Scenario: User can vote question only one time
	When I follow "Euro"
	When I follow "vote up" within ".question-table .vote-cell"
	Then I should see "1" within question "question1"
	When I follow "vote up" within ".question-table .vote-cell"
	Then I should see "1" within question "question1"
	And I should see "You can vote only one time"

@wip @selenium
Scenario: After voting user should see votes +1 on the questions page
	When I follow "Euro"
	When I follow "vote up" within ".question-table .vote-cell"