import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                size: MediaQuery.of(context).size.width * 0.05),
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

class _LongTermGoalCardState extends State<LongTermGoalCard> {
  /// Whether or not the goal is completed
  late var _isCompleted = false;

  /// Whether or not the title is being edited
  bool _isEditing = false;

  /// Whether or not the error text should be shown
  bool _showError = false;

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
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
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
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 9.0, bottom: 0),
                  child: Text(widget.title,
                      style: TextStyle(
                          color: _isCompleted ? Colors.black26 : Colors.black)),
                ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: LinearPercentIndicator(
              animation: true,
              width: MediaQuery.of(context).size.width * 0.5,
              lineHeight: 5.0,
              // TODO: Percent reflects progress
              percent: 0.5,
              linearGradient: const LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
              ),
              barRadius: const Radius.circular(2),
            ),
          ),
          trailing: IconButton(
            // TODO Add functionality to edit button
            onPressed: null,
            icon: IconButton(
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
                  size: MediaQuery.of(context).size.width * 0.05),
            ),
          ),
        ),
      ),
    );
  }
}
