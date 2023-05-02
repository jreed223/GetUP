import "package:flutter/material.dart";
import "package:getup_csc450/helpers/theme_provider.dart";
import "package:provider/provider.dart";

import "../models/goals.dart";
import "../widgets/goal_cards.dart";

class GoalAnimation extends StatefulWidget {
  final dynamic goalCard;
  final dynamic goal;
  const GoalAnimation({super.key, this.goalCard, required this.goal});

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
      duration: const Duration(milliseconds: 500),
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
          backgroundColor: Provider.of<ThemeProvider>(context).scaffoldColor,
          title: Text("Delete Goal",
              style: TextStyle(
                  fontFamily: "PT-Serif",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Provider.of<ThemeProvider>(context).textColor)),
          content: Text("Are you sure you want to delete this goal?",
              style: TextStyle(
                  fontFamily: "PT-Serif",
                  fontSize: 16,
                  color: Provider.of<ThemeProvider>(context).textColor)),
          actions: <Widget>[
            TextButton(
              child: Text("No",
                  style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).buttonColor)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      color: Provider.of<ThemeProvider>(context).buttonColor)),
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
    return widget.goalCard is LongTermGoalCard
        ? GestureDetector(
            onLongPress: () async {
              final confirmed = await _showConfirmationDialog(widget.key);
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
          )
        : widget.goalCard is ShortTermGoalCard
            ? GestureDetector(
                onLongPress: () async {
                  final confirmed = await _showConfirmationDialog(widget.key);
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
              )
            : FadeTransition(
                opacity: _animation!,
                child: widget.goalCard,
              );
  }
}
