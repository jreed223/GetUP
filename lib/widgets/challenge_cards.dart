import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getup_csc450/constants.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'dart:math';
import 'dart:async';
import 'package:getup_csc450/models/challenge.dart';
import 'package:provider/provider.dart';

/// This will be holding the state of all the goals
/// This will be used to update the goals in the database
/// This will be used to update the goals in the UI
ChallengeDataState goalDataState = ChallengeDataState.mainInstance;

class ChallengeCard extends StatefulWidget {
  /// This is the goal that will be displayed
  final Challenge challenge;

  ChallengeCard({super.key, required this.challenge});

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  /// Whether or not the title is being edited
  bool _isEditing = false;

  /// Whether or not the error text should be shown
  bool _showError = false;

  /// Whether or not the goal is completed
  bool _isCompleted = false;

  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  /// Toggles the edit mode for the title
  void toggleEditTitleMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  /// Activates the error text animation
  void showError() {
    setState(() {
      /// Activate the error text animation
      _showError = !_showError;
    });

    /// Deactivate the error text animation after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showError = !_showError;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeDataState>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: screen.displayHeight(context) * 0.075,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: provider.getStatus(widget.challenge.challengeId as String)!
                  ? Color.fromARGB(255, 234, 233, 233)
                  : Colors.white,
              boxShadow: provider.getStatus(widget.challenge.challengeId as String)!
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: .1,
                        blurRadius: .5,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// The checkbox
                  Expanded(
                    flex: 1,
                    child: Checkbox(
                      activeColor: Colors.orange,
                      value: provider.getStatus(widget.challenge.challengeId as String),
                      onChanged: (value) {
                        setState(() {
                          _isCompleted = !_isCompleted;
                        });
                        provider.setStatus(
                            widget.challenge.challengeId as String, value!);
                        provider.updateStatus(widget.challenge.challengeId as String);
                      },
                    ),
                  ),
                  const Spacer(flex: 1),

                  /// The goal title
                  Expanded(
                    flex: 5,

                    /// The title of the goal
                    /// If the goal is in edit mode, a text field is shown
                    child: Text(provider.getTitle(widget.challenge.challengeId as String)!,
                            style: TextStyle(
                                fontSize: 16,
                                // TODO: use change notifier to update the text color
                                color: provider.getStatus(
                                        widget.challenge.challengeId as String)!
                                    ? Colors.black26
                                    : Colors.black)),
                  ),
            
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
