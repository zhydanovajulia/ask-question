@javascript
Feature: In order to have access to the application
		 I as a user
		 try to sign in

Scenario: Try to sign up
	When I try to sign up with "r2d2@r.com"
	Then I should see "Welcome! You have signed up successfully."


Scenario: Try to sign in
  Given a user exists with name: "r2d2", email: "r2d2@r.com"
  When I sign in as user with "r2d2@r.com"
  And I wait for 30 seconds
  Then I should see "Signed in successfully."