import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'dart:math';

// TODO: Add color animations for completed and undo complete
class ShortTermGoalCard extends StatefulWidget {
  /// The title of the goal
  String title;

  /// The index of the goal in the list of goals inside the goal view
  String goalId;

  ShortTermGoalCard({super.key, required this.title, required this.goalId});

  @override
  State<ShortTermGoalCard> createState() => _ShortTermGoalCardState();
}

class _ShortTermGoalCardState extends State<ShortTermGoalCard> {
  /// Whether or not the title is being edited
  bool _isEditing = false;

  /// Whether or not the error text should be shown
  bool _showError = false;

  /// Whether or not the goal is completed
  late var _isCompleted = false;

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

  /// Update status of goal in firebase
  Future updateGoalStatus() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('goals')
        .doc(widget.goalId)
        .update({'isCompleted': _isCompleted});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:
              _isCompleted ? Color.fromARGB(255, 234, 233, 233) : Colors.white,
          boxShadow: _isCompleted
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: .1,
                    blurRadius: .5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
        ),
        child: ListTile(
          leading: Checkbox(
            activeColor: Colors.orange,
            onChanged: (value) {
              setState(() {
                _isCompleted = value!;
                updateGoalStatus();
              });
            },
            value: _isCompleted,
          ),
          title: _isEditing
              ? TextField(
                  cursorColor: Colors.orangeAccent,
                  controller: _titleController,
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      errorText: _showError ? 'Title cannot be empty' : null,
                      hintText: 'Enter a title'),
                  onChanged: (value) {
                    setState(() {
                      value = _titleController.text;
                      widget.title = value;
                    });
                  },
                )
              : Text(widget.title,
                  style: TextStyle(
                      color: _isCompleted ? Colors.black26 : Colors.black)),
          trailing: IconButton(
            onPressed: () async {
              if (_isEditing && _titleController.text.isNotEmpty) {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('goals')
                    .doc(widget.goalId)
                    .update({'title': _titleController.text});
                toggleEditTitleMode();
              } else if (_isEditing && _titleController.text.isEmpty) {
                showError();
              } else {
                toggleEditTitleMode();
              }
            },
            icon: Icon(Icons.edit,
                size: MediaQuery.of(context).size.width * 0.05,
                color: _isCompleted ? Colors.grey[400] : Colors.grey[550]),
          ),
        ),
      ),
    );
  }
}

class LongTermGoalCard extends StatefulWidget {
  String title;

  /// The index of the goal in the list of goals inside the goal view
  String goalId;
  LongTermGoalCard({super.key, required this.title, required this.goalId});

  @override
  State<LongTermGoalCard> createState() => _LongTermGoalCardState();
}

class _LongTermGoalCardState extends State<LongTermGoalCard>
    with TickerProviderStateMixin {
  /// the animation controller for the menu button on the goal card
  late AnimationController menuButtonController;

  /// the animation for the menu button on the goal card
  late Animation<double> menuButtonAnimation;

  /// Whether or not the goal is completed
  late var _isCompleted = false;

  /// Whether or not the title is being edited
  bool _isEditing = false;

  /// Whether the user has exited or cancelled goal editing mode
  bool _isEditingCancelled = false;

  /// Whether or not the error text should be shown
  bool _showError = false;

  /// Whether or not the hours are being edited
  bool _isEditingHours = true;

  /// The height of the goal card
  late double _height = screen.displayHeight(context) * 0.08;

  /// The number of hours the user has worked on the goal
  var _hours = 0;

  /// The number of minutes the user has worked on the goal
  var _minutes = 0;

  /// The progress of the goal
  var _progress;

  var _progressAsPercentage;

  /// Time dedicated to the goal
  var _timeDedicated;

  /// Duration of the goal
  var _duration;

  late TextEditingController _titleController;

  late TextEditingController _progressController;

  /// Saves new progress to firebase
  Future updateProgress() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('goals')
        .doc(widget.goalId)
        .update({'progress': _progress});
  }

  /// Saves new time dedicated to firebase
  Future updateTimeDedicated() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('goals')
        .doc(widget.goalId)
        .update({'timeDedicated': _timeDedicated});
  }

  /// Update status of goal in firebase
  Future updateGoalStatus() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('goals')
        .doc(widget.goalId)
        .update({'isCompleted': _isCompleted});
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _progressController = TextEditingController();
    menuButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    menuButtonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: menuButtonController, curve: Curves.easeInOutBack));
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('goals')
        .doc(widget.goalId)
        .get()
        .then((value) {
      setState(() {
        _progress = value.data()!['progress'];
        _progressAsPercentage = _progress * 100;
        _duration = value.data()!['duration'];
        _timeDedicated = value.data()!['timeDedicated'];
      });
    });
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

  /// Calculates the progress of the goal
  void calculateProgress() {
    setState(() {
      _timeDedicated = _hours + (_minutes / 60);
      _progress = _timeDedicated / _duration;
      _progressAsPercentage = _progress * 100;
      // TODO: Update progress in firebase
      // TODO: Update isCompleted in firebase
      // TODO: Update timeDedicated in firebase
      // TODO: If they decrement back from 100%, update isCompleted to false
      if (_timeDedicated >= _duration) {
        _isCompleted = true;
        updateGoalStatus();
      } else {
        _isCompleted = false;
        updateGoalStatus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),

      /// The goal card
      child: AnimatedContainer(
        curve: Curves.easeInOutBack,
        height: _height,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),

          /// The color of the goal card
          /// If the goal is completed, the color is grey
          color:
              _isCompleted ? Color.fromARGB(255, 234, 233, 233) : Colors.white,

          /// The shadow of the goal card
          /// If the goal is completed, the shadow is grey
          boxShadow: _isCompleted
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: .001,
                    blurRadius: 1,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: .1,
                    blurRadius: .5,
                    offset: const Offset(0, 2), // changes position of shadow
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
                      child: Checkbox(
                        activeColor: Colors.orange,
                        onChanged: (value) {
                          setState(() {
                            _isCompleted = value!;
                            updateGoalStatus();
                          });
                        },
                        value: _isCompleted,
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
                                errorText:
                                    _showError ? 'Title cannot be empty' : null,
                                hintText: 'Edit title'),
                            onChanged: (value) {
                              if (!_isEditingCancelled && value.isNotEmpty) {
                                setState(() {
                                  value = _titleController.text;
                                  widget.title = value;
                                });
                              }
                            },
                          )
                        : Text(widget.title,
                            style: TextStyle(
                                fontSize: 16,
                                color: _isCompleted
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
                            _height = screen.displayHeight(context) * 0.3;
                            _titleController.clear();
                          } else {
                            setState(() {
                              _isEditingCancelled = true;
                            });
                            menuButtonController.reverse();
                            _height = screen.displayHeight(context) * 0.08;
                            _titleController.clear();
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
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
                    // TODO: Percent reflects progress
                    percent: _progress,
                    linearGradient: LinearGradient(
                      colors: _isCompleted
                          ? const [
                              Color.fromARGB(181, 255, 172, 40),
                              Color.fromARGB(173, 255, 109, 40)
                            ]
                          : const [
                              Colors.orangeAccent,
                              Colors.deepOrangeAccent
                            ],
                    ),
                    backgroundColor: _isCompleted
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
                            linearGradient: _isCompleted
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
                            percent: _progress == null
                                ? 0.0
                                : _progress >= 1
                                    ? 1.0
                                    : _progress,
                            center: _progressAsPercentage == null
                                ? const CircularProgressIndicator()
                                : AnimatedFlipCounter(
                                    value: _progressAsPercentage >= 100
                                        ? 100
                                        : _progressAsPercentage,
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

                              /// The indicator for if the hours are editable
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _isEditingHours
                                      ? Color.fromARGB(79, 255, 153, 0)
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
                                        fontSize: 18, color: Colors.black54),
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
                                  child: InkWell(
                                    onTap: () {
                                      if (_isEditingHours && _hours != 0) {
                                        setState(() {
                                          _hours--;
                                        });
                                        calculateProgress();
                                      } else if (_minutes != 0) {
                                        setState(() {
                                          _minutes--;
                                        });
                                        calculateProgress();
                                      }
                                    },

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
                                  child: InkWell(
                                    onTap: () {
                                      calculateProgress();
                                      if (_isEditingHours &&
                                          _hours >= 0 &&
                                          _isCompleted == false) {
                                        setState(() {
                                          print("progress $_progress");
                                          print(
                                              "_time dedicated $_timeDedicated");
                                          print("Duration $_duration");

                                          _hours++;
                                        });
                                        calculateProgress();
                                      } else if (_minutes >= 0 &&
                                          _isCompleted == false) {
                                        setState(() {
                                          _minutes++;
                                        });
                                        calculateProgress();
                                      }
                                    },

                                    /// The plus button
                                    child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        decoration: BoxDecoration(
                                          color: _isCompleted
                                              ? Colors.black12
                                              : Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Center(
                                            child: Text('+',
                                                style: TextStyle(
                                                    color: _isCompleted
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
                                      : Color.fromARGB(79, 255, 153, 0),
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
                                        fontSize: 18, color: Colors.black54),
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
                        onPressed: () {
                          menuButtonController.reverse();
                          setState(() {
                            _isEditing = !_isEditing;
                            _height = screen.displayHeight(context) * 0.08;
                          });
                        },
                        child: const Text('Cancel')),
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 1,

                    /// Save button
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_titleController.text.isNotEmpty) {
                            await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('goals')
                                .doc(widget.goalId)
                                .update({'title': _titleController.text});
                            menuButtonController.reverse();
                            setState(() {
                              _isEditing = !_isEditing;
                              _height = screen.displayHeight(context) * 0.08;
                            });
                          } else {
                            await updateProgress();
                            await updateTimeDedicated();
                            menuButtonController.reverse();
                            setState(() {
                              _isEditing = !_isEditing;
                              _height = screen.displayHeight(context) * 0.08;
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
  }
}
