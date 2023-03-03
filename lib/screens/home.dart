import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:getup_csc450/models/authController.dart';
import 'package:getup_csc450/models/firebaseController.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:getup_csc450/widgets/checkmark.dart';

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

  /// This is the boolean that will determine if the icon is visible
  late bool _iconIsVisible;

  // TODO: Remove this test user, varibales, and function
  /// BELOW IS FOR TESTING ONLY
  /// These variables are the credentials for the test user
  String EMAIL = "main-testing@test.com";
  String PASS = "test1234";
  AuthController authController = AuthController();
  FirestoreController firestoreController = FirestoreController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${authController.getUser!.uid}'),
      ),
      body: Stack(
        children: [
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
                    color: Colors.blue,
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
                                      color: Colors.white,
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
                                      hintText: 'Title',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                // TODO: Make this space relative to the screen size
                                const SizedBox(height: 10),

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
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                        // TODO: Make this space relative to the screen size
                                        const SizedBox(width: 10),

                                        /// This determines if the goal is long term
                                        AnimatedOpacity(
                                          opacity: _isButtonForm ? 1.0 : 0.0,
                                          duration: Duration(
                                              milliseconds:
                                                  _isButtonForm ? 3000 : 1000),
                                          curve: Curves.easeOutCubic,

                                          /// This is the checkbox that will determine if the goal is long term
                                          child: Checkbox(
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
                                      // TODO: Ensure that the input is not empty
                                      // TODO: Add save the input to a variable
                                      // TODO: Ensure that if button is unckecked, the input is cleared
                                      child: TextFormField(
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
                                          hintText: 'Hours to deditcate',
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                    //TODO: Make this space relative to the screen size
                                    const SizedBox(height: 10),

                                    /// This is the button that will submit the form
                                    MaterialButton(
                                        onPressed: () async {
                                          /// This ensures that the form is valid
                                          if (_goalFormKey.currentState!
                                              .validate()) {
                                            try {
                                              /// This pushes a Goal or LongTermGoal to the database depending on if it is long term or not
                                              _isLongTermGoal
                                                  ? FirestoreController.pushGoal(
                                                      LongTermGoal(
                                                          title: _goalTitle,
                                                          duration:
                                                              _goalDuration),
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

                                              /// This shows the checkmark
                                              animatedCheckSwitch();

                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 2000), () {
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
                                                _goalDurationController.clear();
                                                _goalTitleController.clear();
                                                _isLongTermGoal = false;
                                              });
                                            });

                                            /// resetting the checkmark
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 3000), () {
                                              setState(() {
                                                animatedCheckSwitch();
                                              });
                                            });
                                          }
                                          // TODO: Add a function that will reset checkbox and text field
                                        },
                                        color: Colors.white,
                                        textColor: Colors.blue,
                                        child: AnimatedCrossFade(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          firstChild: AnimatedCheckMark(
                                            isFormValid: _submitSuccessful,
                                          ),
                                          secondChild: const Text(
                                            'Submit',
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          crossFadeState: _submitSuccessful
                                              ? CrossFadeState.showFirst
                                              : CrossFadeState.showSecond,
                                        )),
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
              // TODO: Add the rest of the home screen UI widgets here
            ),
          ),
        ],
      ),
    );
  }
}
