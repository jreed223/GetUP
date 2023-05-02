import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:getup_csc450/helpers/theme_provider.dart';
import 'package:getup_csc450/models/firebase_controller.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:getup_csc450/screens/main_screen.dart';
import 'package:getup_csc450/widgets/checkmark.dart';
import 'package:getup_csc450/widgets/calendar.dart';
import 'package:getup_csc450/models/profile_controller.dart';
import 'package:getup_csc450/screens/profile.dart';
import 'package:getup_csc450/screens/metrics.dart';
import 'package:getup_csc450/constants.dart';
import 'package:provider/provider.dart';

import '../helpers/validator.dart';

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

  /// selected index for the bottom navigation bar
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _iconIsVisible = true;
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
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<GoalDataState>(builder: (context, provider, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: themeProvider.scaffoldColor,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: themeProvider.scaffoldColor,
          title: Text('Calendar',
              style: TextStyle(
                  letterSpacing: 1.25,
                  color: themeProvider.textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'PT-Serif')),
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
                          ? themeProvider.scaffoldColor
                          : themeProvider.buttonColor,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  /// This is the title for the form
                                  AnimatedOpacity(
                                    opacity: _isButtonForm ? 1.0 : 0.0,
                                    duration: Duration(
                                        milliseconds:
                                            _isButtonForm ? 3000 : 700),
                                    curve: Curves.easeOutExpo,
                                    child: Text(
                                      'Add a goal',
                                      style: TextStyle(
                                        fontFamily: 'PT-Serif',
                                        color: themeProvider.textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.25,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  /// This is the first text field for the form
                                  AnimatedOpacity(
                                    opacity: _isButtonForm ? 1.0 : 0.0,
                                    duration: Duration(
                                        milliseconds:
                                            _isButtonForm ? 3000 : 700),
                                    curve: Curves.easeOutCubic,
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'PT-Serif',
                                        color: themeProvider.textColor,
                                      ),
                                      cursorColor: themeProvider.buttonColor,
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

                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: themeProvider.buttonColor,
                                              width: 2),
                                        ),
                                        hintText: 'Title',
                                        hintStyle: TextStyle(
                                          fontFamily: 'PT-Serif',
                                          color: themeProvider.textColor
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ),

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
                                                milliseconds: _isButtonForm
                                                    ? 3000
                                                    : 1000),
                                            curve: Curves.easeOutCubic,
                                            child: Text(
                                              'Is this a long term goal?',
                                              style: TextStyle(
                                                fontFamily: 'PT-Serif',
                                                color: themeProvider.textColor,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 5),

                                          /// This determines if the goal is long term
                                          AnimatedOpacity(
                                            opacity: _isButtonForm ? 1.0 : 0.0,
                                            duration: Duration(
                                                milliseconds: _isButtonForm
                                                    ? 3000
                                                    : 1000),
                                            curve: Curves.easeOutCubic,

                                            /// This is the checkbox that will determine if the goal is long term
                                            child: Checkbox(
                                              activeColor:
                                                  themeProvider.buttonColor,
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
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontFamily: 'PT-Serif',
                                              color: themeProvider.textColor),
                                          cursorColor:
                                              themeProvider.buttonColor,
                                          controller: _goalDurationController,
                                          validator: (input) {
                                            /// This ensures the validation only occurs if the checkbox is checked
                                            if (_isLongTermGoal) {
                                              if (input!.isEmpty ||
                                                  !isNumber(input) ||
                                                  int.parse(input) < 1) {
                                                return 'Please enter a valid number';
                                              }
                                            }
                                            return null;
                                          },

                                          /// This saves the input to a variable
                                          onChanged: (input) {
                                            setState(
                                                () => _goalDuration = input);
                                          },
                                          decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      themeProvider.buttonColor,
                                                  width: 3),
                                            ),
                                            hintText: 'Hours to deditcate',
                                            hintStyle: TextStyle(
                                              fontFamily: 'PT-Serif',
                                              color: themeProvider.textColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 30),

                                      /// This is the button that will submit the form
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
                                                color: Colors.black38,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  fontFamily: 'PT-Serif',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 1.25,
                                                ),
                                              )),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              /// This ensures that the form is valid
                                              if (_goalFormKey.currentState!
                                                  .validate()) {
                                                try {
                                                  /// This pushes a Goal or LongTermGoal to the database depending on if it is long term or not
                                                  if (_isLongTermGoal) {
                                                    LongTermGoal newGoal =
                                                        LongTermGoal(
                                                            title: _goalTitle,
                                                            duration: double.parse(
                                                                _goalDuration));
                                                    await FirestoreController
                                                        .pushGoal(
                                                            newGoal,
                                                            _isLongTermGoal,
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid);
                                                    GOAL_STATES
                                                        .addGoal(newGoal);
                                                  } else {
                                                    Goal newGoal =
                                                        Goal(title: _goalTitle);
                                                    await FirestoreController
                                                        .pushGoal(
                                                            newGoal,
                                                            _isLongTermGoal,
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid);
                                                    GOAL_STATES
                                                        .addGoal(newGoal);
                                                  }
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
                                                        milliseconds: 5000),
                                                    () {
                                                  setState(() {
                                                    _goalDurationController
                                                        .clear();
                                                    _goalTitleController
                                                        .clear();
                                                    _isLongTermGoal = false;
                                                  });
                                                });

                                                /// resetting the checkmark and submit button
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 3000),
                                                    () {
                                                  setState(() {
                                                    animatedCheckSwitch();
                                                    growSubmitButton();
                                                  });
                                                });
                                              }
                                            },

                                            /// This is the submit button for the form
                                            child: AnimatedContainer(
                                                curve: Curves.easeInOutBack,
                                                width: _submitButtonWidth,
                                                height: _submitButtonHeight,
                                                decoration: BoxDecoration(
                                                    color: _submitSuccessful
                                                        ? Colors.green
                                                        : themeProvider
                                                            .buttonColor,
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
                                                  secondChild: Center(
                                                    child: Text(
                                                      'Submit',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontFamily: 'PT-Serif',
                                                        color: themeProvider
                                                            .textColor,
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
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: themeProvider.scaffoldColor,
          selectedItemColor: themeProvider.textColor,
          unselectedItemColor: themeProvider.textColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Metrics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }

// Setting up Profile
  Profile profile = Profile.profiles[0];

  /// The function to call when a navigation bar item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MetricsPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(profile: profile)),
        );
        break;
    }
  }
}
