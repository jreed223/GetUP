import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/constants.dart';
import 'package:getup_csc450/widgets/goal_cards.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/goals.dart';

class GoalView extends StatelessWidget {
  /// This is the date that is passed in from the calendar view
  final String selectedDate;

  /// This is the goals collection for the user
  // final goalsCollection = FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('goals');
  GoalView({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    /// This is the stream builder that will display the goals for the selected date
    /// If there are no goals for the selected date, it will display a loading indicator
    // return StreamBuilder(

    //     /// Query the goals collection for the selected date
    //     stream: goalsCollection
    //         .where('dateCreated', isEqualTo: selectedDate)
    //         .snapshots(),
    //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    //         return Center(
    //           child: Text('$selectedDate'),
    //         );
    //       }
    //print(snapshot.data!.docs.length);

    return Consumer<GoalDataState>(
      builder: (context, provider, child) {
        print('Consumer called');
        List<dynamic> filteredGoalsBySelectedDate = [];
        for (dynamic goal in provider.goals) {
          if (goal.formattedCreationDate == selectedDate) {
            print(goal.formattedCreationDate);
            filteredGoalsBySelectedDate.add(goal);
          }
        }
        var goals = filteredGoalsBySelectedDate;
        return ListView.builder(
          itemCount: goals.length,
          itemBuilder: (context, index) {
            /// If the goal is a short term goal, display the short term goal
            /// If the goal is a long term goal, display the long term goal
            return goals[index].isLongTerm == true
                ? LongTermGoalCard(goal: goals[index])
                : ShortTermGoalCard(goal: goals[index]);
          },
        );
      },
    );
  }
}
