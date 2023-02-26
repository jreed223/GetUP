import 'package:flutter/material.dart';

/// This is the form that will be used to create a goal
/// This form will be used in the HomeScreen widget
/// It will be fade in after the user clicks the button
class GoalCreationForm extends StatefulWidget {
  bool isButtonForm;
  GoalCreationForm({required this.isButtonForm, super.key});

  @override
  State<GoalCreationForm> createState() => _GoalCreationFormState();
}

class _GoalCreationFormState extends State<GoalCreationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: widget.isButtonForm ? 1 : 0,
          duration: const Duration(milliseconds: 5000),
          curve: Curves.easeIn,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Goal Name',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 189, 216, 255),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 189, 216, 255),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 189, 216, 255),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
