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
  /// This is the animation controller for the form
  late final AnimationController _goalSlideInController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  /// This is the animation for the form
  late final Animation<Offset> _goalSlideInAnimation;

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
    _goalSlideInAnimation = Tween<Offset>(
      begin: const Offset(-20, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _goalSlideInController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _goalSlideInController.dispose();
    super.dispose();
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
      _buttonWidth = widget.getScreenWidth * 0.27;
      _buttonHeight = widget.getScreenHeight * 0.1;
      _buttonBorderRadius = 20;
      _isButtonForm = true;
    });
  }

  /// This fucntion will move the button to the center of the screen
  void moveDiagonalUp() {
    setState(() {
      bottomPositionVal = 275;
    });
  }

  /// This function initiates the form animation
  void formSlide() {
    _goalSlideInController.forward();
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
                    formSlide();
                  },

                  /// This is the button itself
                  /// It is animated to change shape and size
                  child: AnimatedContainer(
                      curve: Curves.easeInOutBack,
                      duration: const Duration(seconds: 1),
                      width: _buttonWidth,
                      height: _buttonHeight,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                              Radius.circular(_buttonBorderRadius))),

                      /// This is the child of the button
                      /// It is animated to fade in and out
                      /// The stack is used to position the icon and text consistently
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Center(
                            child: AnimatedOpacity(
                              opacity: _iconIsVisisble ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),

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
                          duration: const Duration(milliseconds: 5000),
                          curve: Curves.easeInOutBack,
                          child: Column(
                            children: [
                              const Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Goal',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ])),
                  // Todo: Add the rest of the animation process here
                  // Todo: Add the rest of the home screen UI widgets her
                ))
          ],
        ));
  }
}
