/// These class are responsible for the creation of a new goal.

import 'package:getup_csc450/models/goals.dart';

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
  ShortTermGoalCreator({required String goalTitle})
      : super(goalTitle: goalTitle);

  @override
  Goal createGoal() {
    return Goal(title: goalTitle);
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
  int duration;

  LongTermGoalCreator({required String goalTitle, required this.duration})
      : super(goalTitle: goalTitle);

  @override
  Goal createGoal() {
    return LongTermGoal(title: goalTitle, duration: duration);
  }
}
