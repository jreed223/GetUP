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
  bool isCompleted;

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
        dateCreated = dateCreated ?? DateTime.now(),
        isCompleted = isCompleted ?? false,
        dateCompleted = dateCompleted;

  /// Sets the title of the goal.
  void setTitle(String newTitle) {
    title = newTitle;
  }

  /// Sets the status of the goal.
  void setStatus(bool newStatus) {
    isCompleted = newStatus;
  }

  /// Sets the date the goal was completed.
  void setCompletionDate(DateTime newDate) {
    dateCompleted = newDate;
  }

  void initState() {
    // Code to initialize the state of the challenge
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
  double progress;

  /// The time dedicated to the goal.
  double timeDedicated;

  LongTermGoal(
      {required String title,
      required this.duration,
      double? progress,
      double? timeDedicated,
      bool? isCompleted,
      DateTime? dateCreated,
      DateTime? dateCompleted,
      String? id})
      : progress = progress ?? 0.0,
        timeDedicated = timeDedicated ?? 0.0,
        super(
            title: title,
            isCompleted: isCompleted,
            dateCreated: dateCreated ?? DateTime.now(),
            dateCompleted: dateCompleted,
            id: id);

  /// Sets the title of the goal.
  @override
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
  @override
  void setStatus(bool newStatus) {
    isCompleted = newStatus;
  }

  /// Sets the date the goal was completed.
  @override
  void setCompletionDate(DateTime newDate) {
    dateCompleted = newDate;
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

  /// This is flag to denote if the goals have already been loaded from Firebase
  /// It is set to false by default
  /// It is set to true once the goals have been loaded from Firebase
  /// This ensures that the goals are only loaded from Firebase once
  bool _goalsLoaded = false;

  /// This is the list that stores all the goals.
  List<dynamic> goals = [];

  /// This method returns a list of only the long-term goals
  List<LongTermGoal> get longTermGoals {
    List<LongTermGoal> longTermGoals = [];
    for (var goal in goals) {
      if (goal.isLongTerm) {
        longTermGoals.add(goal);
      }
    }
    return longTermGoals;
  }

  /// This method loads the goals from Firebase
  Future<void> loadGoalsFromFirebase() async {
    /// If the goals have already been loaded, return
    if (_goalsLoaded) {
      return;
    }

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
    _goalsLoaded = true;
    notifyListeners();

    if (goals.isNotEmpty) {
      print('Goals loaded from Firebase');
    }
  }

  /// This will add a new goal to the list of long term goals.
  addGoal(dynamic newGoal) {
    goals.add(newGoal);
    notifyListeners();
  }

  /// This will delete a goal from the list of goals.
  Future<void> deleteGoal(String goalId) async {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        goals.remove(goal);

        /// This is the reference to the goals collection in Firebase
        /// This is used to delete the goal from Firebase
        final CollectionReference goalsCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('goals');

        await goalsCollection.doc(goalId).delete();
        notifyListeners();
        break;
      }
    }
  }

  /// This will set the new title of the goal that is being edited.
  void setTitle(String? goalId, String newTitle) {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        goal.setTitle(newTitle);
        notifyListeners();
        break;
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

    if (!(title == '')) {
      return title;
    }
    return null;
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
    if (!(status == null)) {
      return status;
    }
    return null;
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
    if (!(progress == null)) {
      return progress;
    }
    return null;
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
    if (!(timeDedicated == null)) {
      return timeDedicated;
    }
    return null;
  }

  double? getDuration(String goalId) {
    double duration = 0;
    for (dynamic goal in goals) {
      if (goal.goalId == goalId && goal.isLongTerm == true) {
        duration = goal.goalDuration;
        break;
      }
    }
    if (!(duration == 0)) {
      return duration;
    }
    return null;
  }

  /// This will update the goal progress in Firebase.
  Future<void> updateGoalProgress(String goalId) async {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('goals')
            .doc(goalId)
            .update({
          'progress': goal.goalProgress,
          'timeDedicated': goal.goalTimeDedicated
        });
      }
    }
  }

  /// This will update the goal title in Firebase.
  Future<void> updateTitle(String goalId) async {
    final docRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('goals')
        .doc(goalId);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      for (dynamic goal in goals) {
        if (goal.goalId == goalId) {
          await docRef.update({'title': goal.title});
        }
      }
    }
  }

  /// This will update the goal status in Firebase.
  Future<void> updateStatus(String goalId) async {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('goals')
            .doc(goalId)
            .update({'isCompleted': goal.isCompleted});
      }
    }
  }

  // This will update the date completed in Firebase and local storage.
  Future<void> updateDateCompleted(String goalId, dateTime) async {
    for (dynamic goal in goals) {
      if (goal.goalId == goalId) {
        goal.setCompletionDate(DateTime.now());
        notifyListeners();
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('goals')
            .doc(goalId)
            .update({'dateCompleted': dateTime});
      }
    }
  }
}
