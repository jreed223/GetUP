import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../models/goals.dart";

class GoalAnimation extends StatefulWidget {
  final Key? key;
  dynamic goalCard;
  dynamic goal;
  GoalAnimation({required this.key, this.goalCard, required this.goal});

  @override
  State<GoalAnimation> createState() => _GoalAnimationState();
}

class _GoalAnimationState extends State<GoalAnimation>
    with SingleTickerProviderStateMixin {
  Duration duration = const Duration(milliseconds: 500);
  AnimationController? _controller;
  Animation<double>? _animation;
  bool isDisplayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isDisplayed = true; // set flag to true when animation completes
          });
        }
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!);

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<bool?> _showConfirmationDialog(Key? key) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Goal"),
          content: const Text("Are you sure you want to delete this goal?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () async {
        final confirmed = await _showConfirmationDialog(widget.key);
        print(confirmed);
        if (confirmed == true) {
          _controller!.reverse();
          // delay the deletion of the goal until the animation is complete
          Future.delayed(duration).then((_) {
            Provider.of<GoalDataState>(context, listen: false)
                .deleteGoal(widget.goal.goalId);
          });
        }
      },
      child: FadeTransition(
        opacity: _animation!,
        child: widget.goalCard,
      ),
    );
  }
}
