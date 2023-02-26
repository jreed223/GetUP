import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  double get getScreenWidth =>
      WidgetsBinding.instance.window.physicalSize.width;
  double get getScreenHeight =>
      WidgetsBinding.instance.window.physicalSize.height;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  /// This boolean will determine if the goal is long term or short term
  bool _isLongTermGoal = false;

  /// This is the boolean that will determine if the button is in the form shape
  bool _isButtonForm = false;

  /// This is the border radius for the button
  double _buttonBorderRadius = 50;

  /// This is the position of the button from the bottom of the screen
  double bottomPositionVal = 60;

  /// This is the position of the button from the right of the screen
  double rightPositionVal = 42;

  /// This is the width of the button
  late double _buttonWidth = 75;

  /// This is the height of the button
  late double _buttonHeight = 75;

  /// This is the boolean that will determine if the icon is visible
  late bool _iconIsVisisble;

  @override
  void initState() {
    super.initState();
    _iconIsVisisble = true;
  }

  /// This is the function that will fade out the icon
  void foudOutIcon() {
    setState(() {
      _iconIsVisisble = false;
    });
  }

  /// This is the function that will fade in the icon
  void fadeInIcon() {
    setState(() {
      _iconIsVisisble = true;
    });
  }

  /// This is the function that will change the button from a circle to a square
  void shapeShift() {
    setState(() {
      if (!_isButtonForm) {
        _buttonWidth = widget.getScreenWidth * 0.27;
        _buttonHeight = widget.getScreenHeight * 0.1;
        _buttonBorderRadius = 20;
        _isButtonForm = true;
      } else {
        _buttonWidth = 75;
        _buttonHeight = 75;
        _buttonBorderRadius = 50;
        _isButtonForm = false;
      }
    });
  }

  /// This fucntion will move the button to the center of the screen
  void moveDiagonalUp() {
    setState(() {
      bottomPositionVal = 275;
    });
  }

  void formDiagonalDown() {
    setState(() {
      bottomPositionVal = 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
              customBorder: CircleBorder(),
              onTap: () {
                foudOutIcon();
                shapeShift();
                moveDiagonalUp();

                ///formSlideUp();
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

                  /// This is the child of the button
                  /// It is animated to fade in and out
                  /// The stack is used to position the icon and text consistently
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedOpacity(
                            opacity: _iconIsVisisble ? 1.0 : 0.0,
                            curve: Curves.easeInOutBack,
                            duration: Duration(
                                milliseconds: _isButtonForm ? 1000 : 2000),

                            /// This is the icon that will be animated
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),

                      /// This is the text for the form that will be animated
                      AnimatedOpacity(
                        opacity: _isButtonForm ? 1.0 : 0.0,
                        duration:
                            Duration(milliseconds: _isButtonForm ? 3000 : 300),
                        curve: Curves.easeInOutBack,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              /// This is the title for the form
                              AnimatedOpacity(
                                opacity: _isButtonForm ? 1.0 : 0.0,
                                duration: Duration(
                                    milliseconds: _isButtonForm ? 3000 : 300),
                                curve: Curves.easeOutExpo,
                                child: const Text(
                                  'Add a goal',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              /// This is the first text field for the form
                              AnimatedOpacity(
                                opacity: _isButtonForm ? 1.0 : 0.0,
                                duration: Duration(
                                    milliseconds: _isButtonForm ? 3000 : 300),
                                curve: Curves.easeOutCubic,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Title',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedOpacity(
                                        opacity: _isButtonForm ? 1.0 : 0.0,
                                        duration: Duration(
                                            milliseconds:
                                                _isButtonForm ? 3000 : 300),
                                        curve: Curves.easeOutCubic,
                                        child: const Text(
                                          'Is this a long term goal?',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      /// This determines if the goal is long term
                                      AnimatedOpacity(
                                        opacity: _isButtonForm ? 1.0 : 0.0,
                                        duration: Duration(
                                            milliseconds:
                                                _isButtonForm ? 3000 : 300),
                                        curve: Curves.easeOutCubic,
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
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInBack,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Hours to deditcate',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  /// This is the button that will submit the form
                                  MaterialButton(
                                      onPressed: () {
                                        shapeShift();
                                        formDiagonalDown();
                                        fadeInIcon();
                                      },
                                      color: Colors.white,
                                      textColor: Colors.blue,
                                      child: const Text('Add goal')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Todo: Add the rest of the animation process here
              // Todo: Add the rest of the home screen UI widgets her
            ),
          ),
        ],
      ),
    );
  }
}
