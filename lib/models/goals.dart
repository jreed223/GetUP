/// The goal class is the base class for all goals.
/// It requires the following parameters:
///
/// * [title]: the title of the goal
///
/// The class has a value called isCompleted that is set to false by default.
///
/// The class has a factory constructor called longterm that creates a LongTermGoal.
///
/// Here is an example of how to use the longterm constructor:
/// ```
/// Goal myLongTermGoal = Goal.longterm(title: 'Learn Flutter', duration: 20);
/// ```
///
/// Here are a list of Goal methods:
///
/// * goalTitle: gets the title of the goal
/// * goalStatus: gets the status of the goal
/// * sampleGoalList: gets a list of sample goals

class Goal {
  /// The title of the goal.
  final String title;

  /// Whether the goal is completed.
  bool isCompleted = false;

  Goal({required this.title});

  /// Creates a LongTermGoal.
  factory Goal.longterm({required String title, required int duration}) {
    return LongTermGoal(title: title, duration: duration);
  }

  /// A list <of type Goal> of sample goals.
  final List<Goal> _sampleGoals = [
    Goal.longterm(title: 'Learn Flutter', duration: 20),
    Goal(title: 'Go to grocery store'),
    Goal.longterm(title: 'Read', duration: 5),
    Goal(title: 'Go to the gym'),
    Goal.longterm(title: 'Learn Dart', duration: 10),
    Goal(title: 'Go to the dentist'),
    Goal.longterm(title: 'Learn Python', duration: 15),
  ];

  /// Gets the title of the goal.
  String get goalTitle => title;

  /// Gets the status of the goal.
  bool get goalStatus => isCompleted;

  /// Gets the sample goals.
  List<Goal> get sampleGoalList => _sampleGoals;
}

/// A subclass of Goal that represents a long term goal.
/// It requires the following parameters:
///
/// * [title]: the title of the goal
/// * [duration]: the duration of the goal (hours)
///
/// The class has a value called progress that is set to 0.0 by default.
///
/// Here are a list of LongTermGoal methods:
///
/// * goalDuration: gets the duration of the goal
/// * goalProgress: gets the progress of the goal

class LongTermGoal extends Goal {
  /// The duration of the goal (hours).
  final int duration;

  /// The progress of the goal/how many hours have been spent on it.
  double progress = 0.0;

  LongTermGoal({required String title, required this.duration})
      : super(title: title);

  /// Gets the duration of the goal.
  int get goalDuration => duration;

  /// Gets the progress of the goal.
  double get goalProgress => progress;
}
