[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/t1dqGhBU)
# Overview

Get UP! is a productivity app built with [Flutter](https://flutter.dev/?gclid=CjwKCAiAioifBhAXEiwApzCztruhhC6Wp281ENBwH0oSvjTvKbz8Dz_kP6xWDI1ojDVCzD-StwflNhoCmU0QAvD_BwE&gclsrc=aw.ds). The app allows you to create and complete goals while
monitoring your progress and completions over time.

### Created by

-   Cullin Ryan Capps
-   Cole Roberts
-   Aaron Ayris
-   Jonathan Reed
-   Lukas Becker

### Component Responsibilities

-   User - Cole Roberts
-   Goals (Goal and LongTermGoal) - Cullin Capps
-   MetricsHandler - Jonathan Reed
-   Challenge - Cullin Capps
-   DataPoints - Lukas Becker
-   Database - Cullin Capps

### Getting Started

-   Make sure that you have installed the Flutter and Dart SDK's. See the WIKI if you need help getting any of the two set up.
-   Ensure Git is installed on your machine.
-   Enusre the GitHub CLI is installed on your machine
-   Enusure you have a working emualator (Chrome, MacOS, Android Emulator, etc..)

### Getting and building the project on your machine

#### Step 1

Download the repository from this link: `gh repo clone UNCW-CSC-450/csc450-sp23-project-team-5`

#### Step 2

Run the following command to ensure your dependencies are in order: `flutter pub get `

#### Step 3

Run the following command to execute and build the application: `flutter run main.dart`

#### Step 4

Explore and enjoy our application. Let us know your experience and please give feedback :)



### Aaron - Profile Screen
- User logout button test
Test by pressing the log out button. User is returned to login screen and must log in to proceed
Acceptance Criteria: User has an account and goes to the profile screen to log out.

- User theme change test
Test by pressing the theme button to bring up the theme menu. User chooses between light and dark theme freely. Ensured theme stays as chosen even when closing and re-opening the app.
Acceptance Criteria: User has an account and goes to the profile screen to change the theme.

- User bio and/or interest change test
Test by editing the About or Interest fields, one or the other or neither. User presses the save changes button to save that data to firebase so that it persists until changed.
Failure occurs if the user fails to press the save changes button after making any edits, as the information does not go to firebase.
Deleting all text in the field results in the hint text to add information in the fields to show. User can still save changes and have no text in those fields.
Acceptance Criteria: User has an account and goes to edit one or the other, or both text fields in the profile screen. User must press the save changes button for the information entered to persist once leaving that screen.
