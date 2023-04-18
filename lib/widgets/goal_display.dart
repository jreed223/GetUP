import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/constants.dart';
import 'package:getup_csc450/widgets/goal_cards.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/goals.dart';
import 'filter.dart';

class GoalView extends StatelessWidget {
  /// This is the date that is passed in from the calendar view
  final String selectedDate;

  GoalView({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalDataState>(
      builder: (context, provider, child) {
        List<dynamic> filteredGoalsBySelectedDate = [];
        for (dynamic goal in provider.goals) {
          print('This is the length of goals list ${provider.goals.length}');
          if (goal.formattedCreationDate == selectedDate) {
            filteredGoalsBySelectedDate.add(goal);
          }
        }
        var goals = filteredGoalsBySelectedDate;

        if (goals.isEmpty) {
          return Center(
            child: Text('No goals for selected date'),
          );
        }

        return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              /// if the filter is set to all, display all goals
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'All') {
                return goals[index].isLongTerm == true
                    ? LongTermGoalCard(goal: goals[index])
                    : ShortTermGoalCard(goal: goals[index]);
              }

              /// if the filter is set to long term, display only long term goals
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Long Term') {
                if (goals[index].isLongTerm == true) {
                  return LongTermGoalCard(goal: goals[index]);
                } else {
                  return Container();
                }
              }

              /// if the filter is set to short term, display only short term goals
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Short Term') {
                if (goals[index].isLongTerm == false) {
                  return ShortTermGoalCard(goal: goals[index]);
                } else {
                  return Container();
                }
              }

              /// if the filter is set to completed, display only completed goals
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Completed') {
                if (goals[index].isCompleted == true) {
                  return goals[index].isLongTerm == true
                      ? LongTermGoalCard(goal: goals[index])
                      : ShortTermGoalCard(goal: goals[index]);
                } else {
                  return Container();
                }
              }

              /// if the filter is set to incomplete, display only incomplete goalss
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Incomplete') {
                if (goals[index].isCompleted == false) {
                  return goals[index].isLongTerm == true
                      ? LongTermGoalCard(goal: goals[index])
                      : ShortTermGoalCard(goal: goals[index]);
                } else {
                  return Container();
                }
              }
            });
      },
    );
  }
}
