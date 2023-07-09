# FEATURES

## User Registration
```gherkin
As a new user,
I want to be able to register a new account,
So that I can access personalized features of the app.

Scenario: Successful Registration
    Given I am on the registration screen
    When I enter a valid email
    And I enter a valid password
    And I confirm the password
    And I press the "Register" button
    Then I should see a message "Registration successful"
    And I should be redirected to the login screen

Scenario: Failed Registration - Email Already in Use
    Given I am on the registration screen
    When I enter an email that's already registered
    And I enter a valid password
    And I confirm the password
    And I press the "Register" button
    Then I should see an error message "Email already in use"

Scenario: Failed Registration - Passwords Do Not Match
    Given I am on the registration screen
    When I enter a valid email
    And I enter a valid password
    And I confirm the password with a different value
    And I press the "Register" button
    Then I should see an error message "Passwords do not match"

Scenario: Failed Registration - Invalid Email
    Given I am on the registration screen
    When I enter an invalid email
    And I enter a valid password
    And I confirm the password
    And I press the "Register" button
    Then I should see an error message "Invalid email format"
```