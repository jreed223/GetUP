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

  /// If the goal is a short term goal or a long term goal.
  final bool isLongTerm = false;

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

  /// Get the ID of the goal.
  /// The ID is in the format of goal_title-date_created.
  /// For example, 'Go to the gym - 2021-09-01 12:00:00.000'.
  String get goalID {
    DateFormat formatter = DateFormat('EEEE, MMMM d, y - h:mm a');
    String formattedTimestamp = formatter.format(dateCreated);
    return '$title - $formattedTimestamp';
  }

  /// Gets the title of the goal.
  String get goalTitle => title;

  /// Gets the status of the goal.
  bool get goalStatus => isCompleted;

  /// Gets the sample goals.
  // List<Goal> get sampleGoalList => _sampleGoals;

  /// Gets the date the goal was created.
  String get goalCreationDate {
    DateFormat formatter = DateFormat.yMMMMd('en_US');
    String formattedTimestamp = formatter.format(dateCreated);
    return formattedTimestamp;
  }

  /// Gets the date the goal was completed.
  DateTime? get goalCompletionDate => dateCompleted;

  /// This returns the goal in a JSON format.
  Map<String, dynamic> toJson() {
    return {
      'title': goalTitle,
      'isLongTerm': isLongTerm,
      'isCompleted': goalStatus,
      'dateCreated': goalCreationDate,
      'dateCompleted': goalCompletionDate,
    };
  }

  /// This returns the goal in a JSON format.
  /// This is used in the Firebase controller

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
  final double duration;

  /// The progress of the goal/how many hours have been spent on it.
  double progress = 0.0;

  /// The time dedicated to the goal.
  double timeDedicated = 0.0;

  /// if the goal is a short term goal or a long term goal.
  @override
  final bool isLongTerm = true;

  LongTermGoal({required String title, required this.duration})
      : super(title: title);

  /// Gets the duration of the goal.
  @override
  double get goalDuration => duration;

  /// Gets the progress of the goal.
  @override
  double get goalProgress => progress;

  /// gets the time dedicated to the goal.
  double get goalTimeDedicated => timeDedicated;

  /// This returns the goal in a JSON format.
  @override
  Map<String, dynamic> toJson() {
    return {
      'title': goalTitle,
      'isLongTerm': isLongTerm,
      'isCompleted': goalStatus,
      'dateCreated': goalCreationDate,
      'dateCompleted': goalCompletionDate,
      'duration': goalDuration,
      'progress': goalProgress,
      'timeDedicated': goalTimeDedicated,
    };
  }
}
