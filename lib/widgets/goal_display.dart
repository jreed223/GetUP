import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/goal_animation.dart';
import 'package:getup_csc450/widgets/goal_cards.dart';
import 'package:provider/provider.dart';

import '../models/goals.dart';
import 'filter.dart';

class GoalView extends StatelessWidget {
  /// This is the date that is passed in from the calendar view
  final String selectedDate;

  const GoalView({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalDataState>(
      builder: (context, provider, child) {
        List<dynamic> filteredGoalsBySelectedDate = [];
        for (dynamic goal in provider.goals) {
          if (goal.formattedCreationDate == selectedDate) {
            filteredGoalsBySelectedDate.add(goal);
          }
        }
        var goals = filteredGoalsBySelectedDate;

        if (goals.isEmpty) {
          return const Center(
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
                    ? GoalAnimation(
                        key: ValueKey(goals[index].id),
                        goalCard: LongTermGoalCard(goal: goals[index]),
                        goal: goals[index])
                    : GoalAnimation(
                        key: ValueKey(goals[index].id),
                        goalCard: ShortTermGoalCard(goal: goals[index]),
                        goal: goals[index]);
              }

              /// if the filter is set to long term, display only long term goals
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Long Term') {
                if (goals[index].isLongTerm == true) {
                  return GoalAnimation(
                      key: ValueKey(goals[index].id),
                      goalCard: LongTermGoalCard(goal: goals[index]),
                      goal: goals[index]);
                } else {
                  return Container();
                }
              }

              /// if the filter is set to short term, display only short term goals
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Short Term') {
                if (goals[index].isLongTerm == false) {
                  return GoalAnimation(
                      key: ValueKey(goals[index].id),
                      goalCard: ShortTermGoalCard(goal: goals[index]),
                      goal: goals[index]);
                } else {
                  return Container();
                }
              }

              /// if the filter is set to completed, display only completed goals
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Completed') {
                if (goals[index].isCompleted == true) {
                  return goals[index].isLongTerm == true
                      ? GoalAnimation(
                          key: ValueKey(goals[index].id),
                          goalCard: LongTermGoalCard(goal: goals[index]),
                          goal: goals[index])
                      : GoalAnimation(
                          key: ValueKey(goals[index].id),
                          goalCard: ShortTermGoalCard(goal: goals[index]),
                          goal: goals[index]);
                } else {
                  return Container();
                }
              }

              /// if the filter is set to incomplete, display only incomplete goalss
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Incomplete') {
                if (goals[index].isCompleted == false) {
                  return goals[index].isLongTerm == true
                      ? GoalAnimation(
                          key: ValueKey(goals[index].id),
                          goalCard: LongTermGoalCard(goal: goals[index]),
                          goal: goals[index])
                      : GoalAnimation(
                          key: ValueKey(goals[index].id),
                          goalCard: ShortTermGoalCard(goal: goals[index]),
                          goal: goals[index]);
                } else {
                  return Container();
                }
              }
              return null;
            });
      },
    );
  }
}
