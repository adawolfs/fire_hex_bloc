# A Clean FireBloc

This is a Flutter project that implements Clean Architecture to create a streamlined Firebase app using the Bloc pattern for state management.

## Methodology
The development follows Behaviour-Driven Development (BDD) and Test-Driven Development (TDD) practices to define requirements and implement features.

### BDD
Methodology that aids in defining the requirements of the application in a clear and concise manner. It uses the following structure to define the requirements:

```gherkin
Feature: <feature name>
  As a <role>
  I want <feature>
  So that <benefit>

  Scenario: <scenario name>
    Given <context>
    When <event>
    Then <outcome>
```

In BDD, specifications are written in a human-readable format, which describes the behavior of the application from the user's perspective. This makes it a great tool for collaboration between all stakeholders, including non-technical team members.

### TDD
Development process where you first write a test that defines a function or improvements of a function, which should then fail. This is followed by writing the minimum amount of code to make this test pass, and then refactor the code.

## Clean Architecture
Clean Architecture is a software design philosophy that separates the elements of a design into ring levels. The main rule of Clean Architecture is that code dependencies can only come from the outer levels inward. Code on the inner layers can have no knowledge of functions on the outer layers. The separation of concerns is the main goal of Clean Architecture.

### Layers
The Clean Architecture is made up of the following layers:

- **Entities**: This layer contains the business logic of the application. It is independent of any other layer and can be tested independently.
- **Use Cases**: This layer contains the application-specific business rules. It is also independent of any other layer and can be tested independently.
- **Interface Adapters**: This layer contains the implementations of the interfaces defined in the Use Cases layer. It is dependent on the Use Cases layer, but the Use Cases layer is independent of it. It can be tested independently.
- **Frameworks and Drivers**: This layer contains the implementations of the interfaces defined in the Interface Adapters layer. It is dependent on the Interface Adapters layer, but the Interface Adapters layer is independent of it. It can be tested independently.

### Dependency Rule
The Dependency Rule is the main rule of Clean Architecture. It states that source code dependencies can only point inwards. Nothing in an inner circle can know anything at all about something in an outer circle. The circles can be organized into a hierarchy, where the innermost circle is the most abstract and the outermost circle is the most concrete. The further in you go, the higher level the software becomes. This is called the Abstraction Principle.

## Bloc Pattern
Bloc is a design pattern that helps to separate presentation from business logic. It is based on the idea of dividing the app's logic into three layers:

- **Presentation**: This layer contains the UI code. It is responsible for displaying the UI to the user and for handling user interactions.
- **Business Logic**: This layer contains the business logic of the application. It is responsible for processing data and for making decisions based on that data.
- **Data**: This layer contains the data of the application. It is responsible for fetching data from the network or from the database.
