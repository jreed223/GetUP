import 'package:flutter/material.dart';
import 'package:getup_csc450/constants.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'dart:async';
import 'package:provider/provider.dart';

/// This will be holding the state of all the goals
/// This will be used to update the goals in the database
/// This will be used to update the goals in the UI
GoalDataState goalDataState = GoalDataState.mainInstance;

class ShortTermGoalCard extends StatefulWidget {
  /// This is the goal that will be displayed
  final Goal goal;

  const ShortTermGoalCard({super.key, required this.goal});

  @override
  State<ShortTermGoalCard> createState() => _ShortTermGoalCardState();
}

class _ShortTermGoalCardState extends State<ShortTermGoalCard> {
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
    return Consumer<GoalDataState>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: screen.displayHeight(context) * 0.075,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: provider.getStatus(widget.goal.goalId as String)!
                  ? const Color.fromARGB(255, 234, 233, 233)
                  : Colors.white,
              boxShadow: provider.getStatus(widget.goal.goalId as String)!
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
                      value: provider.getStatus(widget.goal.goalId as String),
                      onChanged: (value) {
                        setState(() {
                          _isCompleted = !_isCompleted;
                        });
                        provider.setStatus(
                            widget.goal.goalId as String, value!);
                        provider.updateStatus(widget.goal.goalId as String);
                        if (value) {
                          provider.updateDateCompleted(
                              widget.goal.goalId as String, DateTime.now());
                        }
                      },
                    ),
                  ),
                  const Spacer(flex: 1),

                  /// The goal title
                  Expanded(
                    flex: 5,

                    /// The title of the goal
                    /// If the goal is in edit mode, a text field is shown
                    child: _isEditing
                        ? TextField(
                            cursorColor: Colors.orangeAccent,
                            controller: _titleController,
                            decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange)),
                                errorText:
                                    _showError ? 'Title cannot be empty' : null,
                                hintText: 'Edit title'),
                            onChanged: (value) {
                              if (!_isEditing && value.isNotEmpty) {
                                setState(() {
                                  value = _titleController.text;
                                });
                                provider.setTitle(
                                    widget.goal.goalId as String, value);
                              }
                            },
                          )
                        : Text(provider.getTitle(widget.goal.goalId as String)!,
                            style: TextStyle(
                                fontSize: 16,
                                color: provider.getStatus(
                                        widget.goal.goalId as String)!
                                    ? Colors.black26
                                    : Colors.black)),
                  ),
                  const Spacer(flex: 1),

                  /// The edit button
                  Expanded(
                    flex: 1,
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 100),
                      crossFadeState: _isEditing
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.edit,
                            size: screen.displayWidth(context) * 0.05),
                        onPressed: () {
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                        },
                      ),
                      secondChild: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.check,
                            size: screen.displayWidth(context) * 0.05),
                        onPressed: () async {
                          if (_titleController.text.isNotEmpty) {
                            setState(() {
                              _isEditing = !_isEditing;
                            });
                            await provider
                                .updateTitle(widget.goal.goalId as String);
                          } else {
                            showError();
                          }
                        },
                      ),
                    ),
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

class LongTermGoalCard extends StatefulWidget {
  /// This is the goal that will be displayed
  final LongTermGoal goal;

  const LongTermGoalCard({super.key, required this.goal});

  @override
  State<LongTermGoalCard> createState() => _LongTermGoalCardState();
}

class _LongTermGoalCardState extends State<LongTermGoalCard>
    with TickerProviderStateMixin {
  /// the animation controller for the menu button on the goal card
  late AnimationController menuButtonController;

  /// the animation for the menu button on the goal card
  late Animation<double> menuButtonAnimation;

  /// The inital value of the progress when the card is first built
  late var _initialProgress;

  /// The progress of the goal
  late var _progress;

  /// The progress of the goal as a percentage
  late var _progressAsPercentage;

  /// The initial value of the time dedicated when the card is first built
  late var _initialTimeDedicated;

  /// Time dedicated to the goal
  late var _timeDedicated;

  /// The initial value of the duration when the card is first built
  late var _initialDuration;

  /// Duration of the goal
  late var _duration;

  /// Whether or not the title is being edited
  late bool _isEditing;

  /// Whether the user has exited or cancelled goal editing mode
  bool _isEditingCancelled = false;

  /// Whether or not the error text should be shown
  bool _showError = false;

  /// Whether or not the hours are being edited
  bool _isEditingHours = true;

  /// Timer for long pressing the plus button for the minutes
  Timer? _timer;

  /// The height of the goal card
  late double _height = screen.displayHeight(context) * 0.08;

  /// The number of hours the user has worked on the goal
  var _hours = 0;

  /// The number of minutes the user has worked on the goal
  var _minutes = 0;

  /// The controller for the title text field
  late TextEditingController _titleController;

  /// Sets the initial values for progress and time dedicated
  void setInitialValues() {
    /// These are used in case the user cancels editing the goal
    _initialProgress = GOAL_STATES.getProgress(widget.goal.goalId as String);
    _initialTimeDedicated =
        GOAL_STATES.getTimeDedicated(widget.goal.goalId as String);
    _initialDuration = GOAL_STATES.getDuration(widget.goal.goalId as String);
    _progressAsPercentage = _initialProgress * 100;

    /// These values are used to calculate the progress
    _progress = _initialProgress;
    _timeDedicated = _initialTimeDedicated;
    _duration = _initialDuration;

    _isEditing = false;
  }

  @override
  void initState() {
    super.initState();
    setInitialValues();

    _titleController = TextEditingController();
    menuButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    menuButtonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: menuButtonController, curve: Curves.easeInOutBack));
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
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showError = !_showError;
      });
    });
  }

  /// Calculates the progress of the goal by adding 1 hour to the progress
  Future<void> addHourToProgress() async {
    double newTimeDedicated = _timeDedicated + 1;
    if (newTimeDedicated >= _duration) {
      _timeDedicated = _duration;
      _progress = 1.0;
      _progressAsPercentage = 100.0;
      GOAL_STATES.setTimeDedicated(
          widget.goal.goalId as String, _timeDedicated);
      GOAL_STATES.setProgress(widget.goal.goalId as String, _progress);
      GOAL_STATES.setStatus(widget.goal.goalId as String, true);
      await GOAL_STATES.updateStatus(widget.goal.goalId as String);
    } else {
      _timeDedicated = newTimeDedicated;
      _progress = _timeDedicated / _duration;
      _progressAsPercentage = _progress * 100;
      GOAL_STATES.setTimeDedicated(
          widget.goal.goalId as String, _timeDedicated);
      GOAL_STATES.setProgress(widget.goal.goalId as String, _progress);
      GOAL_STATES.setStatus(widget.goal.goalId as String, false);
      await GOAL_STATES.updateStatus(widget.goal.goalId as String);
    }
    setState(() {});
  }

  /// Calculates the progress of the goal by subtracting 1 hour from the progress
  Future<void> subtractHourFromProgress() async {
    _timeDedicated -= 1;
    _progress = _timeDedicated / _duration;
    _progressAsPercentage = _progress * 100;
    GOAL_STATES.setTimeDedicated(widget.goal.goalId as String, _timeDedicated);
    GOAL_STATES.setProgress(widget.goal.goalId as String, _progress);
    if (_timeDedicated >= _duration) {
      GOAL_STATES.setStatus(widget.goal.goalId as String, true);
      await GOAL_STATES.updateStatus(widget.goal.goalId as String);
    } else {
      GOAL_STATES.setStatus(widget.goal.goalId as String, false);
      await GOAL_STATES.updateStatus(widget.goal.goalId as String);
    }
    setState(() {});
  }

  /// Calculates the progress of the goal by adding 1 minute to the progress
  Future<void> addMinuteToProgress() async {
    double newTimeDedicated = _timeDedicated + (1 / 60);
    if (newTimeDedicated >= _duration) {
      _timeDedicated = _duration;
      _progress = 1.0;
      _progressAsPercentage = 100.0;
      GOAL_STATES.setTimeDedicated(
          widget.goal.goalId as String, _timeDedicated);
      GOAL_STATES.setProgress(widget.goal.goalId as String, _progress);
      GOAL_STATES.setStatus(widget.goal.goalId as String, true);
      await GOAL_STATES.updateStatus(widget.goal.goalId as String);
    } else {
      _timeDedicated = newTimeDedicated;
      _progress = _timeDedicated / _duration;
      _progressAsPercentage = _progress * 100;
      GOAL_STATES.setTimeDedicated(
          widget.goal.goalId as String, _timeDedicated);
      GOAL_STATES.setProgress(widget.goal.goalId as String, _progress);
      GOAL_STATES.setStatus(widget.goal.goalId as String, false);
      await GOAL_STATES.updateStatus(widget.goal.goalId as String);
    }
    setState(() {});
  }

  /// Calculates the progress of the goal by subtracting 1 minute from the progress
  Future<void> subtractMinuteFromProgress() async {
    double newTimeDedicated = _timeDedicated - (1 / 60);
    if (newTimeDedicated >= 0) {
      setState(() {
        _timeDedicated = newTimeDedicated;
        _progress = _timeDedicated / _duration;
        _progressAsPercentage = _progress * 100;
      });
      GOAL_STATES.setTimeDedicated(
          widget.goal.goalId as String, _timeDedicated);
      GOAL_STATES.setProgress(widget.goal.goalId as String, _progress);
    }
    if (_timeDedicated >= _duration) {
      GOAL_STATES.setStatus(widget.goal.goalId as String, true);
      await GOAL_STATES.updateStatus(widget.goal.goalId as String);
    } else {
      GOAL_STATES.setStatus(widget.goal.goalId as String, false);
      await GOAL_STATES.updateStatus(widget.goal.goalId as String);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalDataState>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(3.0),

          /// The goal card
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            height: _height,
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: provider.getStatus(widget.goal.goalId as String)!
                  ? const Color.fromARGB(255, 234, 233, 233)
                  : Colors.white,
              boxShadow: provider.getStatus(widget.goal.goalId as String)!
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Consumer<GoalDataState>(
                            builder: (context, provider, child) {
                              return Checkbox(
                                activeColor: Colors.orange,
                                onChanged: (_) {
                                  if (provider.getStatus(
                                          widget.goal.goalId as String) ==
                                      true) {
                                    provider.setStatus(
                                        widget.goal.goalId as String, false);
                                    provider.updateStatus(
                                        widget.goal.goalId as String);
                                  } else {
                                    provider.setStatus(
                                        widget.goal.goalId as String, true);
                                    provider.updateStatus(
                                        widget.goal.goalId as String);
                                    provider.updateDateCompleted(
                                        widget.goal.goalId as String,
                                        DateTime.now());
                                  }
                                },
                                value: provider
                                    .getStatus(widget.goal.goalId as String),
                              );
                            },
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 5,

                        /// The title of the goal
                        /// If the goal is in edit mode, a text field is shown
                        child: _isEditing
                            ? TextField(
                                cursorColor: Colors.orangeAccent,
                                controller: _titleController,
                                decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    errorText: _showError
                                        ? 'Title cannot be empty'
                                        : null,
                                    hintText: 'Edit title'),
                                onChanged: (value) {
                                  if (!_isEditingCancelled &&
                                      value.isNotEmpty) {
                                    setState(() {
                                      value = _titleController.text;
                                    });
                                    provider.setTitle(
                                        widget.goal.goalId as String, value);
                                  }
                                },
                              )
                            : Text(
                                provider
                                    .getTitle(widget.goal.goalId as String)!,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: provider.getStatus(
                                            widget.goal.goalId as String)!
                                        ? Colors.black26
                                        : Colors.black)),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 1,

                        /// The gesture detector for the menu button
                        /// If the goal is in edit mode, a cancel button is shown
                        /// If the goal is not in edit mode, a menu button is shown
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEditing = !_isEditing;
                              if (_isEditing) {
                                menuButtonController.forward();
                                _height = screen.displayHeight(context) * 0.325;
                                _titleController.clear();
                              } else {
                                setState(() {
                                  _isEditingCancelled = true;
                                });
                                menuButtonController.reverse();
                                _height = screen.displayHeight(context) * 0.08;
                                _titleController.clear();
                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
                                  setState(() {
                                    _hours = 0;
                                    _minutes = 0;
                                  });
                                });
                              }
                            });
                          },

                          /// The menu button
                          child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: menuButtonController,
                            size: screen.displayWidth(context) * 0.05,
                            semanticLabel: 'Show menu',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8,
                        left: screen.displayWidth(context) * 0.015,
                        bottom: screen.displayHeight(context) * 0.02),

                    /// If the goal is in edit mode, the progress bar is hidden
                    /// If the goal is not in edit mode, the progress bar is shown
                    child: AnimatedOpacity(
                      opacity: _isEditing ? 0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,

                      /// The progress bar
                      child: LinearPercentIndicator(
                        animation: true,
                        width: MediaQuery.of(context).size.width * 0.9,
                        lineHeight: 5.0,
                        percent: provider.getTimeDedicated(
                                widget.goal.goalId as String)! /
                            provider.getDuration(widget.goal.goalId as String)!,
                        linearGradient: LinearGradient(
                          colors:
                              provider.getStatus(widget.goal.goalId as String)!
                                  ? const [
                                      Color.fromARGB(181, 255, 172, 40),
                                      Color.fromARGB(173, 255, 109, 40)
                                    ]
                                  : const [
                                      Colors.orangeAccent,
                                      Colors.deepOrangeAccent
                                    ],
                        ),
                        backgroundColor:
                            provider.getStatus(widget.goal.goalId as String)!
                                ? Colors.blueGrey[150]
                                : Colors.blueGrey[200],
                        barRadius: const Radius.circular(2),
                      ),
                    ),
                  ),

                  /// If the goal is in edit mode, the progress circle is hidden
                  /// If the goal is not in edit mode, the progress circle is shown
                  AnimatedOpacity(
                    opacity: _isEditing ? 1 : 0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,

                            /// The progress circle
                            child: CircularPercentIndicator(
                                linearGradient: provider.getStatus(
                                        widget.goal.goalId as String)!
                                    ? const LinearGradient(colors: [
                                        Colors.greenAccent,
                                        Colors.green,
                                      ])
                                    : const LinearGradient(colors: [
                                        Colors.orangeAccent,
                                        Colors.orange,
                                        Colors.deepOrangeAccent,
                                        Colors.deepOrange
                                      ]),
                                curve: Curves.bounceInOut,
                                radius: screen.displayWidth(context) * 0.125,
                                lineWidth: 10,
                                percent: provider.getTimeDedicated(
                                        widget.goal.goalId as String)! /
                                    provider.getDuration(
                                        widget.goal.goalId as String)!,
                                center: _progressAsPercentage == null
                                    ? const CircularProgressIndicator()
                                    : AnimatedFlipCounter(
                                        value: provider.getTimeDedicated(
                                                widget.goal.goalId as String)! /
                                            provider.getDuration(
                                                widget.goal.goalId as String)! *
                                            100,
                                        suffix: "%",
                                      ),
                                backgroundColor: Colors.black45),
                          ),
                          Expanded(
                            flex: 9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Gesture detector for the hours
                                /// If the user clicks on the hours, the hours are editable
                                /// If the user clicks on the minutes, the minutes are editable
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEditingHours = true;
                                    });
                                  },

                                  /// When the user stops long pressing, the timer is cancelled
                                  onLongPressEnd: (_) => setState(() {
                                    _timer?.cancel();
                                  }),

                                  /// The indicator for if the hours are editable
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _isEditingHours
                                          ? const Color.fromARGB(
                                              79, 255, 153, 0)
                                          : Colors.transparent,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),

                                      /// The hours
                                      child: AnimatedFlipCounter(
                                        prefix: "Update hours: ",
                                        value: _hours,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.bounceOut,
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(children: [
                                    const Spacer(
                                      flex: 2,
                                    ),

                                    /// Gesture detector/inkwell for the minus button
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (_isEditingHours && _hours > 0) {
                                            setState(() {
                                              _hours--;
                                            });
                                            await subtractHourFromProgress();
                                          } else if (_minutes > 0) {
                                            setState(() {
                                              _minutes--;
                                            });
                                            subtractMinuteFromProgress();
                                          }
                                        },

                                        /// Long press on the minus to decrease the minutes
                                        onLongPress: () {
                                          _timer = Timer.periodic(
                                              const Duration(milliseconds: 50),
                                              (timer) {
                                            if (!_isEditingHours &&
                                                _minutes > 0) {
                                              setState(() {
                                                _minutes--;
                                              });
                                              subtractMinuteFromProgress();
                                            }
                                          });
                                        },

                                        /// When the user stops long pressing, the timer is cancelled
                                        onLongPressEnd: (_) => setState(() {
                                          _timer?.cancel();
                                        }),

                                        /// The minus button
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: const Center(
                                                child: Text('-',
                                                    style: TextStyle(
                                                        color: Colors.white)))),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 2,

                                      /// Gesture detector/inkwell for the plus button
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_isEditingHours &&
                                              provider.getStatus(widget.goal
                                                      .goalId as String)! ==
                                                  false) {
                                            setState(() {
                                              _hours += 1;
                                            });
                                            addHourToProgress();
                                          } else if (provider.getStatus(widget
                                                  .goal.goalId as String)! ==
                                              false) {
                                            setState(() {
                                              _minutes++;
                                            });
                                            addMinuteToProgress();
                                          }
                                        },

                                        /// Long press to continuously add
                                        onLongPress: () {
                                          _timer = Timer.periodic(
                                              const Duration(milliseconds: 50),
                                              (timer) {
                                            if (!_isEditingHours &&
                                                provider.getStatus(widget.goal
                                                        .goalId as String)! ==
                                                    false) {
                                              setState(() {
                                                _minutes++;
                                              });
                                              addMinuteToProgress();
                                            }
                                          });
                                        },

                                        /// When the user stops long pressing, the timer is cancelled
                                        onLongPressEnd: (_) => setState(() {
                                          _timer?.cancel();
                                        }),

                                        /// The plus button
                                        child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            decoration: BoxDecoration(
                                              color: provider.getStatus(widget
                                                      .goal.goalId as String)!
                                                  ? Colors.black12
                                                  : Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: Center(
                                                child: Text('+',
                                                    style: TextStyle(
                                                        color: provider
                                                                .getStatus(widget
                                                                        .goal
                                                                        .goalId
                                                                    as String)!
                                                            ? Colors.black45
                                                            : Colors.white)))),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 2,
                                    ),
                                  ]),
                                ),

                                /// Gesture detector for the minutes
                                /// If the user clicks on the minutes, the minutes are editable
                                /// If the user clicks on the hours, the hours are editable
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEditingHours = false;
                                    });
                                  },

                                  /// The indicator for if the minutes are editable
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: _isEditingHours
                                          ? Colors.transparent
                                          : const Color.fromARGB(
                                              79, 255, 153, 0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),

                                      /// The minutes
                                      child: AnimatedFlipCounter(
                                        prefix: "Update minutes: ",
                                        value: _minutes,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.bounceOut,
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screen.displayHeight(context) * 0.02,
                  ),
                  Row(
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 1,

                        /// Cancel button
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 255, 123, 0)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      screen.displaySize(context).width * 0.05),
                                ),
                              ),
                            ),
                            onPressed: () {
                              menuButtonController.reverse();
                              setState(() {
                                _isEditing = !_isEditing;
                                _height = screen.displayHeight(context) * 0.08;
                                _hours = 0;
                                _minutes = 0;
                                _progress = _initialProgress;
                                _timeDedicated = _initialTimeDedicated;
                                _progressAsPercentage = _progress * 100;
                              });
                              provider.setProgress(
                                  widget.goal.goalId as String, _progress);
                              provider.setTimeDedicated(
                                  widget.goal.goalId as String, _timeDedicated);
                              if (_initialProgress != 1) {
                                provider.setStatus(
                                    widget.goal.goalId as String, false);
                              }
                            },
                            child: const Text('Cancel')),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 1,

                        /// Save button
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 255, 123, 0)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      screen.displaySize(context).width * 0.05),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_titleController.text.isNotEmpty) {
                                provider.setTitle(
                                    widget.goal.goalId, _titleController.text);
                                await provider
                                    .updateTitle(widget.goal.goalId as String);
                                menuButtonController.reverse();
                                setState(() {
                                  _isEditing = !_isEditing;
                                  _height =
                                      screen.displayHeight(context) * 0.08;
                                  _hours = 0;
                                  _minutes = 0;
                                });
                              } else {
                                provider.setProgress(
                                    widget.goal.goalId as String, _progress);
                                provider.setTimeDedicated(
                                    widget.goal.goalId as String,
                                    _timeDedicated);
                                await provider.updateGoalProgress(
                                    widget.goal.goalId as String);
                                menuButtonController.reverse();
                                setState(() {
                                  _isEditing = !_isEditing;
                                  _height =
                                      screen.displayHeight(context) * 0.08;
                                  _hours = 0;
                                  _minutes = 0;
                                  _initialProgress = provider.getProgress(
                                      widget.goal.goalId as String);
                                  _initialTimeDedicated =
                                      provider.getTimeDedicated(
                                          widget.goal.goalId as String);
                                  _initialDuration = provider.getDuration(
                                      widget.goal.goalId as String);
                                });
                              }
                            },
                            child: const Text('Save')),
                      ),
                      const Spacer(flex: 1),
                    ],
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
