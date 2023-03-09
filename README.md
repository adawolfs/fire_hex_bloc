# Fire Hex Bloc

## Overview

Fire Hex Bloc is a Flutter application that uses the hexagonal architecture pattern to implement a social network using Firebase services as backend.

The application is composed of three layers: domain, data, and presentation. The domain layer contains the use cases, ports (interfaces), and entities that make up the business logic. The data layer contains the adapters (implementations) of the ports that are used to communicate with firebase services. The presentation layer implements the use cases and the adapters to serve the user interface.

## Domain Layer

The domain layer contains the use cases, ports, and entities that make up the business logic. The use cases are the actions that the user can perform in the application. The ports are the interfaces that the use cases use to communicate with the data layer. The entities are the data models that are used to communicate between the use cases and the ports.

### Use Cases

```gherkin
Feature: User Registration
    As a user
    The User want to register
    So that The User can use the application

Scenario: Successful registration
    Given A User on the registration screen
    When The User enter my name, email, password, and confirm password
    And The User clicks the register button
    Then The User should see a success message
    And The User should receive a confirmation email

Scenario: Invalid email
    Given A User on the registration screen
    When The User enter my name, an invalid email, password, and confirm password
    And The User clicks the register button
    Then The User should see an error message saying the email is invalid

Scenario: Password too short
    Given A User on the registration screen
    When The User enter my name, email, a password that is too short, and confirm password
    And The User clicks the register button
    Then The User should see an error message saying the password is too short

Scenario: Passwords do not match
    Given A User on the registration screen
    When The User enter my name, email, a password, and a confirm password that does not match
    And The User clicks the register button
    Then The User should see an error message saying the passwords do not match

Scenario: Registration failed
    Given A User on the registration screen
    When The User enter my name, email, password, and confirm password
    And The User click the register button
    And The User registration fails
    Then The User should see an error message saying the registration failed
```
