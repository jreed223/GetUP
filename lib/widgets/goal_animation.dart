import 'package:flutter/material.dart';
import 'package:getup_csc450/screens/home.dart';

/// This class is 50% of the goal creation/animation process.
///
/// This class animates the floating action buttons change (Circle --> Square)
/// and also animates the plus icon fading in and out.

class ShapeShift extends StatefulWidget {
  const ShapeShift({super.key});

  double get getScreenWidth =>
      WidgetsBinding.instance.window.physicalSize.width;
  double get getScreenHeight =>
      WidgetsBinding.instance.window.physicalSize.height;

  @override
  State<ShapeShift> createState() => _ShapeShiftState();
}

class _ShapeShiftState extends State<ShapeShift> {
  bool _formMode = false;
  late Alignment _buttonAlignment;
  late double _buttonWidth;
  late double _buttonHeight;
  late bool _iconIsVisisble;

  @override
  void initState() {
    super.initState();
    _buttonWidth = 75;
    _buttonHeight = 75;
    _iconIsVisisble = true;
    _buttonAlignment = Alignment.bottomRight;
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
    });
  }

  void moveDiagonalUp() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          foudOutIcon();
          shapeShift();
          moveDiagonalUp();
        },
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          alignment: _buttonAlignment,
          curve: Curves.bounceInOut,
          child: AnimatedContainer(
              curve: Curves.elasticOut,
              duration: const Duration(seconds: 2),
              width: _buttonWidth,
              height: _buttonHeight,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _iconIsVisisble ? 1 : 0,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ))),
        ));
  }
}

/// This class is the other 50% of the goal creation/animation process.
///
/// It is responsible for animating the floating action button diaganoally

class DiagonalShapeShift extends StatefulWidget {
  const DiagonalShapeShift({super.key});

  @override
  State<DiagonalShapeShift> createState() => _DiagonalShapeShiftState();
}

class _DiagonalShapeShiftState extends State<DiagonalShapeShift> {
  @override
  Widget build(BuildContext context) {
    return const AnimatedAlign(
        duration: Duration(seconds: 1),
        alignment: Alignment.bottomRight,
        child: ShapeShift());
  }
}
