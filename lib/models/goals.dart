import 'package:intl/intl.dart';

/// The goal class is the base class for all goals.
/// It requires the following parameters:
///
/// * [title]: the title of the goal
///
/// The class has a value called isCompleted that is set to false by default.
///
/// Here are a list of Goal methods:
///
/// * goalTitle: gets the title of the goal
/// * goalStatus: gets the status of the goal
/// * sampleGoalList: gets a list of sample goals
class Goal {
  /// The title of the goal.
  String title;

  /// Whether the goal is completed.
  late bool isCompleted = false;

  /// The date the goal was created.
  late DateTime dateCreated = DateTime.now();

  /// The date the goal was completed.
  DateTime? dateCompleted;

  Goal({required this.title});

  /// A list <of type Goal> of sample goals.
  // final List<Goal> _sampleGoals = [
  //   LongTermGoal(title: 'Learn Flutter', duration: '20'),
  //   Goal(title: 'Go to grocery store'),
  //   LongTermGoal(title: 'Read', duration: '20'),
  //   Goal(title: 'Go to the gym'),
  //   LongTermGoal(title: 'Learn Dart', duration: '20'),
  //   Goal(title: 'Go to the dentist'),
  //   LongTermGoal(title: 'Learn Python', duration: '20'),
  // ];

  /// Gets the title of the goal.
  String get goalTitle => title;

  /// Gets the status of the goal.
  bool get goalStatus => isCompleted;

  /// Gets the sample goals.
  // List<Goal> get sampleGoalList => _sampleGoals;

  /// Gets the date the goal was created.
  DateTime get goalCreationDate => dateCreated;

  /// Gets the date the goal was completed.
  DateTime? get goalCompletionDate => dateCompleted;

  /// This returns the goal in a JSON format.
  Map<String, dynamic> toJson() {
    return {
      'title': goalTitle,
      'isCompleted': goalStatus,
      'dateCreated': goalCreationDate,
      'dateCompleted': goalCompletionDate,
    };
  }

  /// Gets the duration of the goal.
  get goalDuration {}

  /// Gets the progress of the goal.
  get goalProgress {}
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
  final String duration;

  /// The progress of the goal/how many hours have been spent on it.
  double progress = 0.0;

  LongTermGoal({required String title, required this.duration})
      : super(title: title);

  /// Gets the duration of the goal.
  @override
  String get goalDuration => duration;

  /// Gets the progress of the goal.
  @override
  double get goalProgress => progress;

  /// This returns the goal in a JSON format.
  @override
  Map<String, dynamic> toJson() {
    return {
      'title': goalTitle,
      'isCompleted': goalStatus,
      'dateCreated': goalCreationDate,
      'dateCompleted': goalCompletionDate,
      'duration': goalDuration,
      'progress': goalProgress,
    };
  }
}
