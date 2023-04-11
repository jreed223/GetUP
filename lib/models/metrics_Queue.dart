import 'package:getup_csc450/models/metricsController.dart';
import 'package:intl/intl.dart';

import 'goals.dart';

class DataQueue {
  final List goalList = GoalDataState().goals;
  List<List> goalQueue = [[], [], [], [], [], [], []];
  List<MetricsData> metricsQueue = [];

  MetricsData m0 = MetricsData(
    numSTcompleted: 0,
    numShortGoals: 0,
    completionPrcnt: 0,
    totalLTprogress: 0,
    totalDuration: 0,
    numLongGoals: 0,
    durationPrcnt: 0,
    numOverallCmplt: 0,
    totalGoals: 0,
    overallCmpltPrcnt: 0,
    overallProgressPrcnt: 0,
  );

  Goal g0 = Goal(title: 'No Goal Data. Create More Goals!');

  DateTime todaysDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String dayOfWeek = DateFormat('EEE').format(DateTime.now());
  late MetricsData currentMetrics;

  ///initializes goals into Queue organize by date last 7 days
  void goalListOrganizer() {
    goalList.sort((a, b) {
      return b.dateCreated
          .compareTo(a.dateCreated); //sorts list using dates ascending order
    });
    goalList.sort();
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
    }
    //intializes days with no goals with 1 empty goal and calculates Metrics for each list of goals
    List listGoal;
    int i = 7;
    for (listGoal in goalQueue) {
      i--;
      if (listGoal.isEmpty) {
        listGoal.add(g0);
        currentMetrics = calcData(listGoal);
        currentMetrics.dataCollectionDate =
            todaysDate.subtract(Duration(days: i));
        currentMetrics.dayOfWeek =
            DateFormat('EEEE').format(todaysDate.subtract(Duration(days: i)));
        metricsQueue.add(currentMetrics);
      } else {
        currentMetrics = calcData(listGoal);
        currentMetrics.dataCollectionDate =
            todaysDate.subtract(Duration(days: i));
        currentMetrics.dayOfWeek =
            DateFormat('EEEE').format(todaysDate.subtract(Duration(days: i)));
        metricsQueue.add(currentMetrics);
      }
    }
  }

  //Adds Goals for current date to metrics Queue
  void addGoals() {
    List todaysGoals = [];
    for (var i = goalList.length - 1; i > 0; i--) {
      var currentGoal = goalList[i];
      if (currentGoal.dateCreated == todaysDate) {
        todaysGoals.add(currentGoal);
      } else if ((currentGoal.isLongTerm == true) &
          (currentGoal.isCompleted == false)) {
        if (currentGoal.dateCreated.isBefore(todaysDate)) {
          todaysGoals.add(currentGoal);
        }
      }
    }
    goalQueue.add(todaysGoals); //Function call add todays goal's to goalQueue
    currentMetrics = calcData(todaysGoals);
    currentMetrics.dataCollectionDate = todaysDate;
    currentMetrics.dayOfWeek = DateFormat('EEEE').format(todaysDate);
    metricsQueue.add(currentMetrics);
    mSize(); // automatic removal
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

List<MetricsData> metricsInitializer(DataQueue data) {
  if (data.metricsQueue.isEmpty) {
    data.goalListOrganizer();
  } else {
    data.addGoals();
  }
  return data.metricsQueue;
}
