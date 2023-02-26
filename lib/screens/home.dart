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

class _HomePageState extends State<HomePage> {
  double _buttonBorderRadius = 50;
  double bottomPositionVal = 60;
  double rightPositionVal = 42;
  late double _buttonWidth = 75;
  late double _buttonHeight = 75;
  late bool _iconIsVisisble;

  @override
  void initState() {
    super.initState();
    _iconIsVisisble = true;
  }

  void foudOutIcon() {
    setState(() {
      _iconIsVisisble = false;
    });
  }

  void fadeInIcon() {
    setState(() {
      _iconIsVisisble = true;
    });
  }

  void shapeShift() {
    setState(() {
      _buttonWidth = widget.getScreenWidth * 0.27;
      _buttonHeight = widget.getScreenHeight * 0.1;
      _buttonBorderRadius = 20;
    });
  }

  void moveDiagonalUp() {
    setState(() {
      bottomPositionVal = 275;
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
                duration: const Duration(seconds: 1),
                curve: Curves.easeInBack,
                bottom: bottomPositionVal,
                right: rightPositionVal,
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    foudOutIcon();
                    shapeShift();
                    moveDiagonalUp();
                  },
                  child: AnimatedContainer(
                      curve: Curves.easeInBack,
                      duration: const Duration(seconds: 1),
                      width: _buttonWidth,
                      height: _buttonHeight,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                              Radius.circular(_buttonBorderRadius))),
                      child: // Todo: Ternary to display goal form or add icon
                          AnimatedOpacity(
                              duration: const Duration(milliseconds: 600),
                              opacity: _iconIsVisisble ? 1 : 0,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ))),
                )),
            // Todo: Add the rest of the animation process here
            // Todo: Add the rest of the home screen UI widgets here
          ],
        ));
  }
}
