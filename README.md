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
-   Challenges - Lukas Becker
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


 ## --- TESTING --- ##
 
### Cole - Login/signup
- Testing user sign up:

    Test by creating an account, filling out all text fields, using an email with a '@' character and '.com' at the end, passwords match, press 'Sign Up' button.
    Acceptance Criteria: Create an acccount, save to database, redirect user to Login page

    Test by not filling out all text fields.
    Acceptance Criteria: Message will display under each field not filled out, telling user it is required

    Test by passwords not matching.
    Acceptance Criteria: Message will display under confirm password field, telling user the passwords do not match

    Test by email not having '@' AND '.com'
    Acceptance Criteria: Message will display under email field, telling user the email is in an invalid format

- Testing user login:

    Test by logging in with a valid email and password, and press the 'Log In' button.
    Acceptance Criteria: User is logged in and sent to Home Page

    Test by logging in with an email that is not linked to an account.
    Acceptance Criteria: Message will display telling user the email and password combo is invalid

     Test by logging in with an email that is valid, but an incorrect password.
    Acceptance Criteria: Message will display telling the user the email and password combo is invalid

    Test by logging in with valid email and password, navigate to the Profile Page, pressing Logout button.
    Acceptance Criteria: User is redirected to the Log In Page

- Testing user staying signed in:

    Test by opening app for the first time on a new device.
    Acceptance Criteria: User is sent to Log In Page

    Test by logging in with valid email and password combo, closing the app, reopening the app.
    Acceptance Criteria: User will be sent to the Home Page, rather than the Log In Page

    Test by logging in with valid email and password combo, navigating to the Profile Page, tapping the Logout button, closing the app, reopening the app.
    Acceptance Criteria: User is directed to the Log In page
    
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

### Lukas - Challenges
- Testing home screen challenges accept button:

    Test by pressing the accept button for a challenge card.
    Acceptance Criteria: the challenge card turns green plus the description and accept button are replaced with the text 'status: accepted'.

    Test by pressing the accept button for a challenge card. 
    Acceptance Criteria: go to the challenge view on the calendar page, there should be a card there for the accepted challenge.

- Testing challenge checkbox on calendar page:

    Test by checking off the checkbox for a challenge.
    Acceptance Criteria: The challenge card should be greyed out and the value of isCompleted should be True.

    Test by unchecking the checkbox for a challenge.
    Acceptance Criteria: The challenge card should no longer be greyed out and the value of isCompleted should be False.

- Testing challenges saving in firebase:

    Test by accepting a challenge and adding it to the calendar page. Now that a challenge is there close and reopen the app.
    Acceptance Criteria: The challenge should still be displayed on the calendar page.

    Test by checking off and completing a challenge on the calendar page, then close and reopen the app.
    Acceptance Criteria: The challenge should remain checked off when you reopen the app.

