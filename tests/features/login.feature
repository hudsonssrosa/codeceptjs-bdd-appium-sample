@login-sample
Feature: Automation Sample App
	In order to authenticate
	As a user
	I want to be able to login with my credentials

	Scenario: Login the user with its credentials
		Given that app is open
		When I provide wrong credentials
		Then I see "Wrong username or password"