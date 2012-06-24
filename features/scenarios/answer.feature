@javascript
Feature: In order to manage answers
		 I as a user
		 try to create, update and vote answers

Background:
	Given a user "r2d2" exists with name: "r2d2", email: "r2d2@r.com"
	And a question "question1" exists with subject: "Euro", description: "description", user: user "r2d2"
	And a question "question2" exists with subject: "Alien", description: "2"
  	And I sign in as user with "r2d2@r.com"