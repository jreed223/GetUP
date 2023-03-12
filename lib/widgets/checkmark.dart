import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedCheckMark extends StatefulWidget {
  /// This is a boolean value that determines whether the animation should be
  bool isFormValid;

  /// This is the constructor for the class
  /// [isFormValid] is a boolean value that determines whether the animation should be shown
  /// [key] is the key for the widget, the key is used to identify the widget
  /// If the key/parameter changes, the widget will be rebuilt using the new key
  AnimatedCheckMark({Key? key, required this.isFormValid})
      : super(key: ValueKey(isFormValid));

  @override
  State<AnimatedCheckMark> createState() => _AnimatedCheckMarkState();
}

class _AnimatedCheckMarkState extends State<AnimatedCheckMark>
    with SingleTickerProviderStateMixin {
  /// This is the animation controller for the animation
  late final AnimationController _controller;

  /// This is the initState method
  @override
  void initState() {
    super.initState();

    /// Initialize the animation controller with a duration of 2 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    /// If the form is valid, start the animation
    if (widget.isFormValid) {
      _controller.forward();
    }
  }

  /// This is the dispose method
  /// This method is called when the widget is removed from the widget tree
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// This method is called when the widget is rebuilt
  /// Recall that the widget is rebuilt when the key/parameter changes
  /// oldWidget is the previous version of the widget
  @override
  void didUpdateWidget(covariant AnimatedCheckMark oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// If the form is valid, start the animation
    if (widget.isFormValid) {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reset();
      }
      _controller.forward();

      /// If the form is not valid, reverse the animation
    } else {
      if (_controller.status == AnimationStatus.forward) {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Lottie.network(
            'https://assets3.lottiefiles.com/packages/lf20_QUlmCaIOR4.json',
            fit: BoxFit.cover,
            controller: _controller, onLoaded: (composition) {
          if (widget.isFormValid) {
            /// If the animation is completed, reset the animation
            if (_controller.status == AnimationStatus.completed) {
              _controller.reset();
            }
            _controller
              ..duration = composition.duration
              ..forward();

            /// If the form is not valid, reverse the animation
          } else {
            if (_controller.status == AnimationStatus.forward) {
              _controller.reverse();
            }
          }
        }),
      ),
    );
  }
}
