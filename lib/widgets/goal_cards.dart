import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

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

  /// Whether or not the error text should be shown
  bool _showError = false;

  /// The height of the goal card
  late double _height = screen.displayHeight(context) * 0.08;

  /// The number of hours the user has worked on the goal
  var _hours = 0;

  /// The number of minutes the user has worked on the goal
  var _minutes = 0;

  late TextEditingController _titleController;

  late TextEditingController _progressController;

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
        new CurvedAnimation(
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
        curve: Curves.easeInOutBack,
        height: _height,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:
              _isCompleted ? Color.fromARGB(255, 234, 233, 233) : Colors.white,
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
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
                    Expanded(
                      flex: 5,
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
                                setState(() {
                                  value = _titleController.text;
                                  widget.title = value;
                                });
                              },
                            )
                          : Text(widget.title,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: _isCompleted
                                      ? Colors.black26
                                      : Colors.black)),
                    ),
                    Spacer(flex: 1),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEditing = !_isEditing;
                            if (_isEditing) {
                              menuButtonController.forward();
                              _height = screen.displayHeight(context) * 0.3;
                            } else {
                              menuButtonController.reverse();
                              _height = screen.displayHeight(context) * 0.08;
                            }
                          });
                        },
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
                // TODO: If editing, show circle percent indicator
                // TODO: If not editing, show linear percent indicator
                // TODO: If editing, show flip counters with button to updagte progress
                // TODO: If editing, have cacel and save buttons
                Padding(
                  padding: EdgeInsets.only(
                      top: 8,
                      left: screen.displayWidth(context) * 0.015,
                      bottom: screen.displayHeight(context) * 0.02),
                  child: AnimatedOpacity(
                    opacity: _isEditing ? 0 : 1.0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    child: LinearPercentIndicator(
                      animation: true,
                      width: MediaQuery.of(context).size.width * 0.88,
                      lineHeight: 5.0,
                      // TODO: Percent reflects progress
                      percent: 0.5,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            opacity: _isEditing ? 1 : 0,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CircularPercentIndicator(
                                        radius:
                                            screen.displayWidth(context) * 0.15,
                                        lineWidth: 10,
                                        percent: 0.5,
                                        center: Text('50%',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: _isCompleted
                                                    ? Colors.black26
                                                    : Colors.black)),
                                        progressColor: _isCompleted
                                            ? Colors.blueGrey[150]
                                            : Colors.blueGrey[200],
                                        backgroundColor: Colors.black45),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedFlipCounter(
                                        prefix: "Update hours: ",
                                        value: _hours,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.bounceOut,
                                        textStyle: TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                      AnimatedFlipCounter(
                                        prefix: "Update minutes: ",
                                        value: _minutes,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.bounceOut,
                                        textStyle: TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(onPressed: null, child: Text('Cancel')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
