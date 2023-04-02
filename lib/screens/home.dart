import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:getup_csc450/models/authController.dart';
import 'package:getup_csc450/models/firebaseController.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:getup_csc450/widgets/checkmark.dart';
import 'package:getup_csc450/widgets/calendar.dart';
import 'package:getup_csc450/models/profileController.dart';
import 'package:getup_csc450/screens/profile.dart';
import 'package:getup_csc450/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  /// This boolean detmines if a checkmark is visible
  bool _submitSuccessful = false;

  /// This boolean determines if error animation is visible
  bool _submitUnsuccessful = false;

  /// This boolean will determine if the goal is long term or short term
  bool _isLongTermGoal = false;

  /// This is the boolean that will determine if the button is in the form shape
  bool _isButtonForm = false;

  /// This is the title of the goal that will capture the user input
  String _goalTitle = "";

  /// This is the duration of the goal that will capture the user input
  String _goalDuration = "";

  /// This is the controller for database access
  final FirestoreController _firestoreDatabase = FirestoreController();

  /// This is the key for the form
  /// It is used to validate and check the state of the form
  final GlobalKey<FormState> _goalFormKey = GlobalKey<FormState>();

  /// This is the controller for the goal title
  final TextEditingController _goalTitleController = TextEditingController();

  /// This is the controller for the goal duration
  final TextEditingController _goalDurationController = TextEditingController();

  /// This is the border radius for the button
  late double _buttonBorderRadius = screen.displayHeight(context) * 0.05;

  /// This is the position of the button from the bottom of the screen
  late double bottomPositionVal = screen.displayHeight(context) / 20;

  /// This is the position of the button from the right of the screen
  late double rightPositionVal = screen.displayWidth(context) / 15;

  /// This is the width of the button
  late double _buttonWidth = screen.displayWidth(context) / 7;

  /// This is the height of the button
  late double _buttonHeight = screen.displayHeight(context) / 15;

  /// This is the width of the submit button
  late double _submitButtonWidth = screen.displayWidth(context) / 2;

  /// This is the height of the submit button
  late double _submitButtonHeight = screen.displayHeight(context) / 20;

  /// This is the border radius for the submit button
  late double _submitButtonBorderRadius = screen.displayHeight(context) * 0.05;

  /// This is the boolean that will determine if the icon is visible
  late bool _iconIsVisible;

  // TODO: Remove this test user, varibales, and function
  /// BELOW IS FOR TESTING ONLY
  /// These variables are the credentials for the test user
  String EMAIL = "main-testing@test.com";
  String PASS = "test1234";
  AuthController authController = AuthController();
  FirestoreController firestoreController = FirestoreController();
  Profile profile = Profile.profiles[0];

  /// This function is used to help me test if the goals are being stored to the database
  Future signInTestUser() async {
    try {
      final credential =
          await authController.signInWithEmailAndPassword(EMAIL, PASS);
      await FirestoreController.saveUserInfo(
          EMAIL, "newest", "yoooooo", authController.getUser!.uid);
      print("User information saved successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _iconIsVisible = true;
    signInTestUser();
    print('Init bruv');
    GOAL_STATES
        .loadGoalsFromFirebase()
        .then((_) => GOAL_STATES.printLongTermGoals());
  }

  /// This is the function that will show the animated checkmark
  void animatedCheckSwitch() {
    setState(() {
      _submitSuccessful = !_submitSuccessful;
    });
  }

  /// This is the function that will show the animated error
  void animatedErrorSwitch() {
    setState(() {
      _submitUnsuccessful = !_submitUnsuccessful;
    });
  }

  /// This is the function that will fade out the icon
  void fadeOutIcon() {
    setState(() {
      _iconIsVisible = false;
    });
  }

  /// This is the function that will fade in the icon
  void fadeInIcon() {
    setState(() {
      _iconIsVisible = true;
    });
  }

  /// This is the function that will change the button from a circle to a square
  void shapeShift() {
    setState(() {
      if (!_isButtonForm) {
        _buttonWidth = screen.displayWidth(context) / 1.15;
        _buttonHeight = screen.displayHeight(context) / 2.5;
        _buttonBorderRadius = screen.displayHeight(context) * 0.05;
        _isButtonForm = true;
      } else {
        _buttonWidth = screen.displayWidth(context) / 7;
        _buttonHeight = screen.displayHeight(context) / 15;
        _buttonBorderRadius = screen.displayHeight(context) * 0.05;
        _isButtonForm = false;
      }
    });
  }

  /// This fucntion will move the button to the center of the screen
  void moveDiagonalUp() {
    setState(() {
      bottomPositionVal = screen.displayHeight(context) / 3;
    });
  }

  /// This function will move the button to the bottom right of the screen
  void moveDiagonalDown() {
    setState(() {
      bottomPositionVal = screen.displayHeight(context) / 20;
    });
  }

  // TODO: Rename function to something more appropriate
  // TODO: Add another function for the other half of the animation
  /// This function is the entire animation
  /// It will call all the other functions that will animate the button
  /// The functions need to wrapped due to dart's syntax
  /// See the onTap function in the button
  void goalCreationAninmation() {
    shapeShift();
    moveDiagonalUp();
    fadeOutIcon();
  }

  /// This is the function that will shrink the submit button
  void shrinkSubmitButton() {
    setState(() {
      _submitButtonWidth = screen.displayWidth(context) / 10;
      _submitButtonHeight = screen.displayHeight(context) / 25;
      _submitButtonBorderRadius = screen.displayHeight(context) * 0.05;
    });
  }

  /// This is the function that will return the submit button to its original size
  void growSubmitButton() {
    setState(() {
      _submitButtonWidth = screen.displayWidth(context) / 2;
      _submitButtonHeight = screen.displayHeight(context) / 20;
      _submitButtonBorderRadius = screen.displayHeight(context) * 0.05;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: const Text('O V E R V I E W',
            style: TextStyle(
              color: Color.fromARGB(132, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            )),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(profile: profile)),
              );
            },
            icon: const Icon(Icons.person),
            color: Color.fromARGB(255, 255, 119, 0),
          )
        ],
      ),
      body: Stack(
        children: [
          CalendarWidget(),

          /// This is the floating action button
          /// It is positioned at the bottom right of the screen

          /// When the user taps the button, it will animate to the center
          /// The button will also animate from a circle to a square

          /// When the button arrives in the center, a form will appear inside
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInBack,
            bottom: bottomPositionVal,
            right: rightPositionVal,
            child: InkWell(
              customBorder: const CircleBorder(),

              /// This is the function that will animate the button
              onTap: () {
                /// This is the function that will animate the button
                /// If all of the animations are not wrapped in a function, the button will not animate

                /// If the button is in the form shape, it is not clickable
                /// This ensures that if the user clicks the background of the form, it will not animate
                _isButtonForm ? null : goalCreationAninmation();
              },

              /// This is the button itself
              /// It is animated to change shape and size
              child: SingleChildScrollView(
                child: AnimatedContainer(
                  curve: Curves.easeInOutBack,
                  duration: const Duration(seconds: 1),
                  width: _buttonWidth,
                  height: _buttonHeight,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87.withOpacity(0.5),
                        spreadRadius: .25,
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    color: _isButtonForm
                        ? Colors.white
                        : Color.fromARGB(255, 255, 119, 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_buttonBorderRadius),
                    ),
                  ),

                  /// These are the children of the button
                  /// They are animated to fade in and out
                  /// The stack is used to position the icon and form text consistently
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedOpacity(
                              opacity: _iconIsVisible ? 1.0 : 0.0,
                              curve: Curves.easeInOutBack,
                              duration: Duration(
                                  milliseconds: _isButtonForm ? 800 : 2000),

                              /// This is the icon that will be animated
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                      ),

                      /// This is the text for the form that will be animated
                      Form(
                        key: _goalFormKey,
                        child: AnimatedOpacity(
                          opacity: _isButtonForm ? 1.0 : 0.0,
                          duration: Duration(
                              milliseconds: _isButtonForm ? 3000 : 700),
                          curve: Curves.easeInOutBack,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                /// This is the title for the form
                                AnimatedOpacity(
                                  opacity: _isButtonForm ? 1.0 : 0.0,
                                  duration: Duration(
                                      milliseconds: _isButtonForm ? 3000 : 700),
                                  curve: Curves.easeOutExpo,
                                  child: const Text(
                                    'Add a goal',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),

                                /// TODO: Make this space relative to the screen size
                                const SizedBox(height: 5),

                                /// This is the first text field for the form
                                AnimatedOpacity(
                                  opacity: _isButtonForm ? 1.0 : 0.0,
                                  duration: Duration(
                                      milliseconds: _isButtonForm ? 3000 : 700),
                                  curve: Curves.easeOutCubic,
                                  // TODO: Ensure title doesnt already exist in goals
                                  child: TextFormField(
                                    cursorColor: Colors.black38,
                                    controller: _goalTitleController,

                                    /// This ensures that the title is not empty
                                    validator: (input) {
                                      if (input!.isEmpty) {
                                        return 'Please enter a title for your goal';
                                      }
                                      return null;
                                    },

                                    /// This saves the title to a variable
                                    onChanged: (input) {
                                      setState(() => _goalTitle = input);
                                    },
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black54, width: 3),
                                      ),
                                      hintText: 'Title',
                                      hintStyle: TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ),
                                ),

                                // TODO: Make this space relative to the screen size
                                const SizedBox(height: 5),

                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AnimatedOpacity(
                                          opacity: _isButtonForm ? 1.0 : 0.0,
                                          duration: Duration(
                                              milliseconds:
                                                  _isButtonForm ? 3000 : 1000),
                                          curve: Curves.easeOutCubic,
                                          child: const Text(
                                            'Is this a long term goal?',
                                            style: TextStyle(
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ),

                                        // TODO: Make this space relative to the screen size
                                        const SizedBox(width: 5),

                                        /// This determines if the goal is long term
                                        AnimatedOpacity(
                                          opacity: _isButtonForm ? 1.0 : 0.0,
                                          duration: Duration(
                                              milliseconds:
                                                  _isButtonForm ? 3000 : 1000),
                                          curve: Curves.easeOutCubic,

                                          /// This is the checkbox that will determine if the goal is long term
                                          child: Checkbox(
                                            activeColor: Colors.black54,
                                            value: _isLongTermGoal,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isLongTermGoal =
                                                    !_isLongTermGoal;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                    /// If the checkbox is checked, this text field will appear
                                    AnimatedOpacity(
                                      opacity: _isLongTermGoal ? 1.0 : 0.0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInBack,
                                      // TODO: Ensure that the input is a number
                                      // TODO: Ensure that if button is unckecked, the input is cleared
                                      child: TextFormField(
                                        cursorColor: Colors.black12,
                                        controller: _goalDurationController,
                                        validator: (input) {
                                          /// This ensures the validation only occurs if the checkbox is checked
                                          if (_isLongTermGoal) {
                                            if (input!.isEmpty) {
                                              return 'Please enter a number of hours to dedicate to this goal';
                                            }
                                          }
                                          return null;
                                        },

                                        /// This saves the input to a variable
                                        onChanged: (input) {
                                          setState(() => _goalDuration = input);
                                        },
                                        decoration: const InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black54,
                                                width: 3),
                                          ),
                                          hintText: 'Hours to deditcate',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ),

                                    //TODO: Make this space relative to the screen size
                                    const SizedBox(height: 30),

                                    /// This is the button that will submit the form
                                    // TODO: Make this button an animated container
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            shapeShift();
                                            moveDiagonalDown();
                                            fadeInIcon();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 55,
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Center(
                                                child: const Text('Cancel')),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            /// This ensures that the form is valid
                                            if (_goalFormKey.currentState!
                                                .validate()) {
                                              try {
                                                /// This pushes a Goal or LongTermGoal to the database depending on if it is long term or not
                                                _isLongTermGoal
                                                    ? FirestoreController.pushGoal(
                                                        LongTermGoal(
                                                            title: _goalTitle,
                                                            duration: double.parse(
                                                                _goalDuration)),
                                                        _isLongTermGoal,
                                                        authController
                                                            .getUser!.uid)
                                                    : FirestoreController
                                                        .pushGoal(
                                                            Goal(
                                                                title:
                                                                    _goalTitle),
                                                            false,
                                                            authController
                                                                .getUser!.uid);

                                                /// This adds the goal to the state
                                                _isLongTermGoal
                                                    ? GoalDataState.mainInstance
                                                        .addLongTermGoal(
                                                            LongTermGoal(
                                                                title:
                                                                    _goalTitle,
                                                                duration: double
                                                                    .parse(
                                                                        _goalDuration)))
                                                    : GoalDataState.mainInstance
                                                        .addShortTermGoal(Goal(
                                                            title: _goalTitle));
                                                GoalDataState
                                                    .mainInstance.longTermGoals
                                                    .forEach((element) {
                                                  print(element.title);
                                                });

                                                shrinkSubmitButton();

                                                /// This shows the submit checkmark
                                                animatedCheckSwitch();

                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 2000),
                                                    () {
                                                  shapeShift();
                                                  moveDiagonalDown();
                                                  fadeInIcon();
                                                });
                                              } catch (e) {
                                                print(e);
                                              }

                                              /// clearing input fields after submit
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 5000), () {
                                                setState(() {
                                                  // TODO: Add a wrapper function that will reset all the fields
                                                  _goalDurationController
                                                      .clear();
                                                  _goalTitleController.clear();
                                                  _isLongTermGoal = false;
                                                });
                                              });

                                              /// resetting the checkmark and submit button
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                setState(() {
                                                  animatedCheckSwitch();
                                                  growSubmitButton();
                                                });
                                              });
                                            }
                                            // TODO: Add a function that will reset checkbox and text field
                                          },

                                          /// This is the submit button for the form
                                          child: AnimatedContainer(
                                              curve: Curves.easeInOutBack,
                                              width: _submitButtonWidth,
                                              height: _submitButtonHeight,
                                              decoration: BoxDecoration(
                                                  color: _submitSuccessful
                                                      ? Colors.green
                                                      : Color.fromARGB(
                                                          14, 0, 0, 0),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          _submitButtonBorderRadius))),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              child: AnimatedCrossFade(
                                                alignment: Alignment.center,
                                                secondCurve: Curves.easeOut,
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                firstChild: Center(
                                                  child: AnimatedCheckMark(
                                                    isFormValid:
                                                        _submitSuccessful,
                                                  ),
                                                ),
                                                secondChild: const Center(
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                                crossFadeState:
                                                    _submitSuccessful
                                                        ? CrossFadeState
                                                            .showFirst
                                                        : CrossFadeState
                                                            .showSecond,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
