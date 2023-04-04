import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  /// The ID of the goal.
  final String id;

  /// The title of the goal.
  String title;

  /// Whether the goal is completed.
  bool isCompleted = false;

  /// The date the goal was created.
  final DateTime dateCreated;

  /// The date the goal was completed.
  DateTime? dateCompleted;

  /// If the goal is a short term goal or a long term goal.
  final isLongTerm = false;

  Goal({
    required this.title,
    String? id,
    bool? isCompleted,
    DateTime? dateCreated,
    DateTime? dateCompleted,
  })  : id = id ?? const Uuid().v4(),
        dateCreated = dateCreated ?? DateTime.now();

  /// Sets the title of the goal.
  set goalTitle(String newTitle) {
    title = newTitle;
  }

  /// Sets the status of the goal.
  set goalStatus(bool newStatus) {
    isCompleted = newStatus;
  }

  /// Gets the ID of the goal.
  String? get goalId => id;

  /// Gets the title of the goal.
  String get goalTitle => title;

  /// Gets the status of the goal.
  bool get goalStatus => isCompleted;

  /// Gets the date the goal was created.
  DateTime get goalCreationDate => dateCreated;

  /// This is done to match the table calendar date format.
  String get formattedCreationDate {
    return DateFormat.yMMMMd().format(dateCreated);
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
      'goalId': goalId,
    };
  }

  /// This returns the goal from a JSON format.
  static Goal fromJson(Map<String, dynamic> json) {
    return Goal(
        title: json['title'],
        isCompleted: json['isCompleted'],

        /// This ensures that the date is in the correct format.
        dateCreated: (json['dateCreated'] as Timestamp).toDate(),

        /// This ensures that the date is in the correct format.
        /// If the date is null, it will be set to null.
        dateCompleted: (json['dateCreated'] as Timestamp).toDate(),
        id: json['goalId']);
  }
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
/// * goalTimeDedicated: gets the time dedicated to the goal
/// * setStatus: sets the status of the goal
/// * setTitle: sets the title of the goal
/// * setProgress: sets the progress of the goal
/// * setTimeDedicated: sets the time dedicated to the goal
///

class LongTermGoal extends Goal {
  /// The duration of the goal (hours).
  final double duration;

  /// The progress of the goal/how many hours have been spent on it.
  double progress = 0.0;

  /// The time dedicated to the goal.
  double timeDedicated = 0.0;

  LongTermGoal(
      {required String title,
      required this.duration,
      double? progress,
      double? timeDedicated,
      bool? isCompleted,
      DateTime? dateCreated,
      DateTime? dateCompleted,
      String? id})
      : super(
            title: title,
            isCompleted: isCompleted,
            dateCreated: DateTime.now(),
            dateCompleted: null,
            id: id);

  /// Sets the title of the goal.
  void setTitle(String newTitle) {
    title = newTitle;
  }

  /// Sets the progress of the goal.
  void setProgress(double newProgress) {
    progress = newProgress;
  }

  /// Sets the time dedicated to the goal.
  void setTimeDedicated(double newTimeDedicated) {
    timeDedicated = newTimeDedicated;
  }

  /// Sets the status of the goal.
  void setStatus(bool isCompleted) {
    this.isCompleted = isCompleted;
  }

  /// Gets the duration of the goal.
  double get goalDuration => duration;

  /// Gets the progress of the goal.
  double get goalProgress => progress;

  /// Gets the time dedicated to the goal.
  double get goalTimeDedicated => timeDedicated;

  @override
  bool get isLongTerm => true;

  /// This returns the goal in a JSON format.
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'duration': goalDuration,
      'progress': goalProgress,
      'timeDedicated': goalTimeDedicated,
    });
    return json;
  }

  /// This returns the goal from a JSON format.
  static LongTermGoal fromJson(Map<String, dynamic> json) {
    return LongTermGoal(
      title: json['title'],
      duration: json['duration'].toDouble(),
      progress: json['progress'].toDouble(),
      timeDedicated: json['timeDedicated'].toDouble(),
      isCompleted: json['isCompleted'],
      dateCreated: (json['dateCreated'] as Timestamp).toDate(),
      dateCompleted: (json['dateCreated'] as Timestamp).toDate(),
      id: json['goalId'],
    );
  }
}

/// This class stores the state of the goal data
/// It extends ChangeNotifier so that it can notify its listener when the goal data changes
/// It provides methods to modify the goal data
/// It also provides getters to access the goal data
class GoalDataState extends ChangeNotifier {
  /// This is the only instance of the GoalDataState class
  static final GoalDataState mainInstance =
      GoalDataState._mainInstanceCreator();

  /// This is the constructor for the GoalDataState class
  /// It is private so that it can only be called by the getInstance method
  /// This ensures that there is only one instance of the GoalDataState class
  GoalDataState._mainInstanceCreator();

  /// This method returns the only instance of the GoalDataState class
  /// If the instance has not been created yet, it will create the instance
  factory GoalDataState() {
    return mainInstance;
  }

  bool test = false;

  /// This is the list that stores all the goals.
  List<dynamic> goals = [];

  /// This method loads the goals from Firebase
  Future<void> loadGoalsFromFirebase() async {
    /// This is the reference to the goals collection in Firebase
    final CollectionReference goalsCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('goals');

    // Retrieve all the goals from the Firestore collection
    QuerySnapshot querySnapshot = await goalsCollection.get();

    // Iterate over each document in the collection
    // Check if the document represents a short-term or a long-term goal
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['isLongTerm']) {
        goals.add(LongTermGoal.fromJson(data));
      } else {
        goals.add(Goal.fromJson(data));
      }
    }
    notifyListeners();
  }

  /// This will add a new goal to the list of long term goals.
  void addGoal(dynamic newGoal) {
    goals.add(newGoal);
    notifyListeners();
  }

  void printLongTermGoals() {
    for (LongTermGoal goal in goals) {
      print(goal.goalId);
    }
  }

  /// This will set the new title of the goal that is being edited.
  void setTitle(String? goalId, String newTitle) {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        goal.setTitle(newTitle);
        notifyListeners();
        break;
      } else {
        print('** setTitle ** => goal not found');
      }
    }
  }

  /// This will set the new status of the goal that is being edited.
  void setStatus(String goalId, bool newStatus) {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        goal.setStatus(newStatus);
        notifyListeners();
        break;
      } else {
        print('** setStatus ** => goal not found');
      }
    }
  }

  /// This will set the new progress of the goal that is being edited.
  void setProgress(String goalId, double newProgress) {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId && goal.isLongTerm == true) {
        goal.setProgress(newProgress);
        notifyListeners();
        break;
      }
    }
  }

  /// This will set the new time dedicated to the goal that is being edited.
  void setTimeDedicated(String goalId, double newTimeDedicated) {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId && goal.isLongTerm == true) {
        goal.setTimeDedicated(newTimeDedicated);
        notifyListeners();
        break;
      }
    }
  }

  /// This will set the new date completed of the goal that is being edited.
  // void setDateCompleted(String goalId, DateTime newDateCompleted) {
  //   for (Goal goal in _shortTermGoals) {
  //     if (goal.goalId == goalId) {
  //       goal.dateCompleted = newDateCompleted;
  //       notifyListeners();
  //       break;
  //     }
  //   }
  // }

  /// This will return the title of the goal that is being edited.
  String? getTitle(String goalId) {
    String title = '';
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        title = goal.title;
        break;
      }
    }

    if (title == '') {
      print('** getTitle ** => goal not found');
    } else {
      return title;
    }
  }

  /// This will return the status of the goal that is being edited.
  bool? getStatus(String goalId) {
    bool? status;
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        status = goal.isCompleted;
        break;
      }
    }
    if (status == null) {
      print('** getStatus ** => goal not found');
    } else {
      return status;
    }
  }

  /// This will return the progress of the goal that is being edited.
  double? getProgress(String goalId) {
    double? progress;
    for (dynamic goal in goals) {
      if (goal.goalId == goalId && goal.isLongTerm == true) {
        progress = goal.goalProgress;
        break;
      }
    }
    if (progress == null) {
      print('** getProgress ** => goal not found');
    } else {
      return progress;
    }
  }

  /// This will return the time dedicated to the goal that is being edited.
  double? getTimeDedicated(String goalId) {
    double? timeDedicated;
    for (dynamic goal in goals) {
      if (goal.goalId == goalId && goal.isLongTerm == true) {
        timeDedicated = goal.timeDedicated;
        break;
      }
    }
    if (timeDedicated == null) {
      print('** getTimeDedicated ** => goal not found');
    } else {
      return timeDedicated;
    }
  }
}

/// This class will listen to changes made in GoalDataState and update the UI.
/// It extends InheritedNotifier so that it can listen to changes made in GoalDataState.
/// It provides getters to access the goal data.
class GoalDataEventListener extends InheritedNotifier<GoalDataState> {
  final GoalDataState _goalDataState;

  GoalDataEventListener({
    Key? key,
    required GoalDataState goalDataState,
    required Widget child,
  })  : _goalDataState = goalDataState,
        super(key: key, notifier: goalDataState, child: child);

  static GoalDataState of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<GoalDataEventListener>()
            ?._goalDataState ??
        (throw Exception('Goal data not found'));
  }
}
