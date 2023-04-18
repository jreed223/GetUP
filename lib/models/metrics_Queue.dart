import 'package:getup_csc450/models/data_points.dart';
import 'package:getup_csc450/models/metricsController.dart';
import 'package:intl/intl.dart';

import 'goals.dart';
import 'package:getup_csc450/constants.dart';

DateTime todaysDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
String dayOfWeek = DateFormat('EEE').format(DateTime.now());
late MetricsData currentMetrics;

class MetricsQueue {
  static final MetricsQueue _instance = MetricsQueue._internal();

  List<MetricsData> _currentMetricsQ = [];

  factory MetricsQueue() {
    return _instance;
  }

  MetricsQueue._internal();

  bool metricsLoaded = false;

  List<MetricsData> getMetricsData() {
    setMetrics();
    return _currentMetricsQ;
  }

  void setMetrics() {
    if (_currentMetricsQ.isEmpty) {
      data.goalListOrganizer();
      metricsLoaded = true;
      _currentMetricsQ = data.metricsQueue;
    } else if (_currentMetricsQ.isNotEmpty) {
      addMetrics();
      sizeMetrics();
    }
  }

  void sizeMetrics() {
    if ((_currentMetricsQ.length > 7) &
        (_currentMetricsQ[6]
            .dataCollectionDate
            .isAtSameMomentAs(_currentMetricsQ[7].dataCollectionDate))) {
      _currentMetricsQ.removeAt(6);
    } else if ((_currentMetricsQ.length > 7) &
        (_currentMetricsQ[6]
            .dataCollectionDate
            .isBefore(_currentMetricsQ[7].dataCollectionDate))) {
      _currentMetricsQ.removeAt(0);
    }
  }

  List<MetricsData> addMetrics() {
    List todaysGoals = [];
    for (var currentGoal in GOAL_STATES.goals) {
      DateTime goalDate = DateTime(currentGoal.goalCreationDate.year,
          currentGoal.goalCreationDate.month, currentGoal.goalCreationDate.day);
      DateTime completionDate = DateTime(
          currentGoal.goalCompletionDate.year,
          currentGoal.goalCompletionDate.month,
          currentGoal.goalCompletionDate.day);
      if ((goalDate.isAtSameMomentAs(todaysDate)) ||
          (completionDate.isAtSameMomentAs(todaysDate))) {
        todaysGoals.add(currentGoal);
      } else if ((currentGoal.isLongTerm == true) &
          (currentGoal.isCompleted == false)) {
        if (currentGoal.dateCreated.isBefore(todaysDate)) {
          todaysGoals.add(currentGoal);
        }
      }
    }
    var currentMetrics = calcData(todaysGoals);
    currentMetrics.dataCollectionDate = todaysDate;
    currentMetrics.dayOfWeek = DateFormat('EEEE').format(todaysDate);
    _currentMetricsQ.add(currentMetrics);
    sizeMetrics(); // automatic removal
    metricsLoaded = true;
    return _currentMetricsQ;
  }
}

class DataQueue {
  final List goalList = GOAL_STATES.goals;
  List<List> goalQueue = [[], [], [], [], [], [], []];
  List<MetricsData> metricsQueue = [];

  MetricsData m0 = MetricsData(
    numSTcompleted: 0,
    numShortGoals: 0,
    stCompletionPrcnt: 0,
    totalLTprogress: 0,
    totalDuration: 0,
    numLongGoals: 0,
    durationPrcnt: 0,
    numOverallCmplt: 0,
    totalGoals: 0,
    overallCmpltPrcnt: 0,
    overallProgressPrcnt: 0,
  );

  ///initializes goals into Queue organize by date last 7 days
  void goalListOrganizer() {
    goalList.sort((a, b) {
      return b.dateCreated
          .compareTo(a.dateCreated); //sorts list using dates ascending order
    });
    // goalList.sort();
    var currentGoal;
    for (currentGoal in goalList) {
      DateTime goalDate = DateTime(currentGoal.goalCreationDate.year,
          currentGoal.goalCreationDate.month, currentGoal.goalCreationDate.day);
      if (currentGoal is LongTermGoal || currentGoal is Goal) {
        if (goalDate.isAtSameMomentAs(todaysDate)) {
          goalQueue[6].add(currentGoal);
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted == false)) {
          if (currentGoal.dateCreated.isBefore(todaysDate)) {
            goalQueue[6].add(currentGoal);
          }
        }

        if (goalDate
            .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 1)))) {
          goalQueue[5].add(currentGoal);
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted == false)) {
          if (currentGoal.dateCreated
              .isBefore(todaysDate.subtract(const Duration(days: 1)))) {
            goalQueue[5].add(currentGoal);
          }
        }

        if (goalDate
            .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 2)))) {
          goalQueue[4].add(currentGoal);
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted == false)) {
          if (currentGoal.dateCreated
              .isBefore(todaysDate.subtract(const Duration(days: 2)))) {
            goalQueue[4].add(currentGoal);
          }
        }

        if (goalDate
            .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 3)))) {
          goalQueue[3].add(currentGoal);
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted == false)) {
          if (currentGoal.dateCreated
              .isBefore(todaysDate.subtract(const Duration(days: 3)))) {
            goalQueue[3].add(currentGoal);
          }
        }

        if (goalDate
            .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 4)))) {
          goalQueue[2].add(currentGoal);
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted == false)) {
          if (currentGoal.dateCreated
              .isBefore(todaysDate.subtract(const Duration(days: 4)))) {
            goalQueue[2].add(currentGoal);
          }
        }

        if (goalDate
            .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 5)))) {
          goalQueue[1].add(currentGoal);
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted == false)) {
          if (currentGoal.dateCreated
              .isBefore(todaysDate.subtract(const Duration(days: 5)))) {
            goalQueue[1].add(currentGoal);
          }
        }

        if (goalDate
            .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 6)))) {
          goalQueue[0].add(currentGoal);
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted == false)) {
          if (currentGoal.dateCreated
              .isBefore(todaysDate.subtract(const Duration(days: 6)))) {
            goalQueue[0].add(currentGoal);
          }
        }
      }
      print("Goal List accessed length =  ${goalList.length}");
    }
    //intializes days with no goals with 1 empty goal and calculates Metrics for each list of goals
    List listGoal;
    int i = 7;
    for (listGoal in goalQueue) {
      i--;

      currentMetrics = calcData(listGoal);
      currentMetrics.dataCollectionDate =
          todaysDate.subtract(Duration(days: i));
      currentMetrics.dayOfWeek =
          DateFormat('EEEE').format(todaysDate.subtract(Duration(days: i)));
      metricsQueue.add(currentMetrics);
    }
    METRICS_QUEUE._currentMetricsQ = metricsQueue;
  }

  void mSize() {
    if ((metricsQueue.length > 7) &
        (metricsQueue[6]
            .dataCollectionDate
            .isAtSameMomentAs(currentMetrics.dataCollectionDate))) {
      metricsQueue.removeAt(6);
    } else if ((metricsQueue.length > 7) &
        (metricsQueue[6]
            .dataCollectionDate
            .isBefore(currentMetrics.dataCollectionDate))) {
      metricsQueue.removeAt(0);
    }
  }
}

// List<MetricsData> addGoals(DataQueue data) {
//   List todaysGoals = [];
//   for (var currentGoal in data.goalList) {
//     DateTime goalDate = DateTime(currentGoal.goalCreationDate.year,
//         currentGoal.goalCreationDate.month, currentGoal.goalCreationDate.day);
//     DateTime completionDate = DateTime(
//         currentGoal.goalCompletionDate.year,
//         currentGoal.goalCompletionDate.month,
//         currentGoal.goalCompletionDate.day);
//     if ((goalDate.isAtSameMomentAs(data.todaysDate)) ||
//         (completionDate.isAtSameMomentAs(data.todaysDate))) {
//       todaysGoals.add(currentGoal);
//     } else if ((currentGoal.isLongTerm == true) &
//         (currentGoal.isCompleted == false)) {
//       if (currentGoal.dateCreated.isBefore(data.todaysDate)) {
//         todaysGoals.add(currentGoal);
//       }
//     }
//   }
//   var currentMetrics = calcData(todaysGoals);
//   currentMetrics.dataCollectionDate = data.todaysDate;
//   currentMetrics.dayOfWeek = DateFormat('EEEE').format(data.todaysDate);
//   data.metricsQueue.add(currentMetrics);
//   data.mSize(); // automatic removal
// }

List<MetricsData> metricsInitializer(DataQueue data) {
  data.goalListOrganizer();
  return data.metricsQueue;
}

// List<MetricsData> setMetrics(
//     DataQueue data, List<MetricsData> currentMetricsQ) {
//   if (currentMetricsQ.isEmpty) {
//     currentMetricsQ = metricsInitializer(data);
//   } else if (currentMetricsQ.isNotEmpty) {
//     List todaysGoals = [];
//     for (var currentGoal in data.goalList) {
//       DateTime goalDate = DateTime(currentGoal.goalCreationDate.year,
//           currentGoal.goalCreationDate.month, currentGoal.goalCreationDate.day);
//       DateTime completionDate = DateTime(
//           currentGoal.goalCompletionDate.year,
//           currentGoal.goalCompletionDate.month,
//           currentGoal.goalCompletionDate.day);
//       if ((goalDate.isAtSameMomentAs(data.todaysDate)) ||
//           (completionDate.isAtSameMomentAs(data.todaysDate))) {
//         todaysGoals.add(currentGoal);
//       } else if ((currentGoal.isLongTerm == true) &
//           (currentGoal.isCompleted == false)) {
//         if (currentGoal.dateCreated.isBefore(data.todaysDate)) {
//           todaysGoals.add(currentGoal);
//         }
//       }
//     }
//     var currentMetrics = calcData(todaysGoals);
//     currentMetrics.dataCollectionDate = data.todaysDate;
//     currentMetrics.dayOfWeek = DateFormat('EEEE').format(data.todaysDate);
//     data.metricsQueue.add(currentMetrics);
//     data.mSize();
//     currentMetricsQ = data.metricsQueue; // automatic removal
//   }
//   return currentMetricsQ;
// }
