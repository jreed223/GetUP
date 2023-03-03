/// These class are responsible for the creation of a new goal.

import 'package:getup_csc450/models/goals.dart';
import 'package:getup_csc450/models/firebaseController.dart';
import 'package:getup_csc450/models/authController.dart';

/// The [GoalCreationController] class is the base class for all goal creation
///
/// It requires the following parameters:
///
/// * [goalTitle]: the title of the goal
///
/// Here are a list of Goal methods:
///
/// * createGoal: creates a new goal
class GoalCreationController {
  String goalTitle;

  GoalCreationController({required this.goalTitle});

  createGoal() {}
}

/// A subclass of [GoalCreationController] that represents a short term goal.
///
/// It requires the following parameters:
///
/// * [goalTitle]: the title of the goal
///
/// Here are a list of [ShortTermGoalCreator] methods:
///
/// * createGoal: creates a new short term goal
class ShortTermGoalCreator extends GoalCreationController {
  final Goal goal;

  ShortTermGoalCreator({required goalTitle})
      : goal = Goal(title: goalTitle),
        super(goalTitle: goalTitle);

  @override
  Goal createGoal() {
    return goal;
  }

  Map toJson() {
    return {
      'title': goal.goalTitle,
      'isCompleted': goal.goalStatus,
      'dateCreated': goal.goalCreationDate,
      'dateCompleted': 'N/A',
    };
  }
}

/// A subclass of [GoalCreationController] that represents a long term goal.
///
/// It requires the following parameters:
///
/// * [goalTitle]: the title of the goal
/// * [duration]: the duration of the goal (hours)
///
/// Here are a list of [LongTermGoalCreator] methods:
///
/// * createGoal: creates a new long term goal
class LongTermGoalCreator extends GoalCreationController {
  String duration;

  LongTermGoalCreator({required String goalTitle, required this.duration})
      : super(goalTitle: goalTitle);

  @override
  Goal createGoal() {
    LongTermGoal newGoal = LongTermGoal(title: goalTitle, duration: duration);
    return newGoal;
  }
}
