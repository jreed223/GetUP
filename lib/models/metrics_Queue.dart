import "package:getup_csc450/models/metrics_controller.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime todaysDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
String dayOfWeek = DateFormat('EEE').format(DateTime.now());
late MetricsData currentMetrics;

class MetricsQueue {
  static final MetricsQueue _instance = MetricsQueue._internal();

  //List goalList = [];
  List<MetricsData> currentMetricsQ = [];
  List goalQueue = [[], [], [], [], [], [], []];

  List initialMetrics = [];

  bool _dataSaved = false;

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

  factory MetricsQueue() {
    // if (_instance.currentMetricsQ.length < 7) {
    //   _instance.loadMetrics(goalList);
    // } else {
    //   _instance.addMetrics(goalList);
    // }

    return _instance;
  }

  List<MetricsData> setMetricsQ(goalList) {
    if (currentMetricsQ.length < 7) {
      loadMetrics(goalList);
    } else {
      addMetrics(goalList);
    }
    return currentMetricsQ;
  }

  MetricsQueue._internal();

  //----Methods for saving and loading Json data----//

  // saveData(MetricsData metricsData) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   String json = jsonEncode(metricsData);
  //   String dataDate =
  //       DateFormat('yyyy-MM-dd').format(metricsData.dataCollectionDate!);
  //   if (pref.containsKey(dataDate)) {
  //     deleteData(metricsData.dataCollectionDate!);
  //   }
  //   pref.setString(dataDate, json);
  // }

  // loadData(DateTime dataDateTime) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String dataDate = DateFormat('yyyy-MM-dd').format(dataDateTime);

  //   if (pref.containsKey(dataDate)) {
  //     _dataSaved = true;
  //     String? json = pref.getString(dataDate);
  //     Map<String, dynamic> data = jsonDecode(json!);
  //     MetricsData cachedData = MetricsData.fromJson(data);
  //     cachedData.dataCollectionDate = dataDateTime;
  //     cachedData.dayOfWeek = DateFormat('EEEE').format(dataDateTime);
  //     // return cachedData;
  //     currentMetricsQ.add(cachedData);
  //     return;
  //   } else {
  //     return;
  //   }
  // }

  // deleteData(DateTime dataDateTime) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String dataDate = DateFormat('yyyy-MM-dd').format(dataDateTime);
  //   if (pref.containsKey(dataDate)) {
  //     pref.remove(dataDate);
  //   }
  //   return;
  //   print("data deleted");
  // }

  // void goalListOrganizer() {
  //   for (var currentGoal in goalList) {
  //     DateTime creationDate = DateTime(currentGoal.goalCreationDate.year,
  //         currentGoal.goalCreationDate.month, currentGoal.goalCreationDate.day);

  //     if (creationDate
  //         .isAtSameMomentAs(todaysDate.subtract(Duration(days: dayDec)))) {
  //       goalQueue[listInc].add(currentGoal);
  //     } else if ((currentGoal.isLongTerm == true) &
  //         (currentGoal.isCompleted == false)) {
  //       if (creationDate
  //           .isBefore(todaysDate.subtract(Duration(days: dayDec)))) {
  //         goalQueue[listInc].add(currentGoal);
  //       }
  //     } else if ((currentGoal.isLongTerm == true) &
  //         (currentGoal.isCompleted = true)) {
  //       if (currentGoal.goalCompletionDate != null) {
  //         DateTime completionDate = DateTime(
  //             currentGoal.goalCompletionDate.year,
  //             currentGoal.goalCompletionDate.month,
  //             currentGoal.goalCompletionDate.day);

  //         if (completionDate
  //             .isAtSameMomentAs(todaysDate.subtract(Duration(days: dayDec)))) {
  //           goalQueue[listInc].add(currentGoal);
  //         }
  //       }
  //     }
  //   }
  // }

  void loadMetrics(goalList) {
    int dayDec = 6;
    int dayInc = 0;
    int listInc = 0;
    while (dayDec >= 0) {
      //  loadData(todaysDate.subtract(Duration(days: dayDec)));

      // if (_dataSaved == true) {
      //   //Do nothing
      // } else if (_dataSaved == false) {
      for (var currentGoal in goalList) {
        DateTime creationDate = DateTime(
            currentGoal.goalCreationDate.year,
            currentGoal.goalCreationDate.month,
            currentGoal.goalCreationDate.day);

        if (creationDate
            .isAtSameMomentAs(todaysDate.subtract(Duration(days: dayDec)))) {
          goalQueue[listInc].add(currentGoal);
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted == false)) {
          if (creationDate
              .isBefore(todaysDate.subtract(Duration(days: dayDec)))) {
            goalQueue[listInc].add(currentGoal);
          }
        } else if ((currentGoal.isLongTerm == true) &
            (currentGoal.isCompleted = true)) {
          if (currentGoal.goalCompletionDate != null) {
            DateTime completionDate = DateTime(
                currentGoal.goalCompletionDate.year,
                currentGoal.goalCompletionDate.month,
                currentGoal.goalCompletionDate.day);

            if (completionDate.isAtSameMomentAs(
                todaysDate.subtract(Duration(days: dayDec)))) {
              goalQueue[listInc].add(currentGoal);
            }
          }
        }

        MetricsData newMetrics = calcData(goalQueue[listInc]);
        newMetrics.dataCollectionDate =
            todaysDate.subtract(Duration(days: dayDec));
        newMetrics.dayOfWeek =
            DateFormat.E().format(todaysDate.subtract(Duration(days: dayDec)));
        currentMetricsQ.add(newMetrics);
        // saveData(newMetrics);
      }

      // inspect(_currentMetricsQ);
      dayDec--;
      listInc++;
    }
  }

  void sizeMetrics() {
    //inspect(currentMetricsQ);
    while (currentMetricsQ.length > 7) {
      if (currentMetricsQ[6]
          .dataCollectionDate!
          .isAtSameMomentAs(currentMetricsQ[7].dataCollectionDate!)) {
        currentMetricsQ.removeAt(6);
      } else if (currentMetricsQ[6]
          .dataCollectionDate!
          .isBefore(currentMetricsQ[7].dataCollectionDate!)) {
        //deleteData(currentMetricsQ[0].dataCollectionDate);
        currentMetricsQ.removeAt(0);
      }
    }
  }

  void addMetrics(goalList) {
    List todaysGoals = [];
    for (var currentGoal in goalList) {
      DateTime goalDate = DateTime(currentGoal.goalCreationDate.year,
          currentGoal.goalCreationDate.month, currentGoal.goalCreationDate.day);

      if ((goalDate.isAtSameMomentAs(todaysDate)) ||
          ((currentGoal.isLongTerm == true) &
              (currentGoal.isCompleted == false))) {
        todaysGoals.add(currentGoal);
      } else if (currentGoal.goalCompletionDate != null) {
        DateTime completionDate = DateTime(
            currentGoal.goalCompletionDate.year,
            currentGoal.goalCompletionDate.month,
            currentGoal.goalCompletionDate.day);
        if (completionDate.isAtSameMomentAs(todaysDate)) {
          todaysGoals.add(currentGoal);
        }
      }
    }
    var currentMetrics = calcData(todaysGoals);
    currentMetrics.dataCollectionDate = todaysDate;
    currentMetrics.dayOfWeek = DateFormat.E().format(todaysDate);
    currentMetricsQ.add(currentMetrics);
    //saveData(currentMetrics);
    sizeMetrics();
    saveData(currentMetrics); // automatic removal
    metricsLoaded = true;
    return currentMetricsQ;
  }
}

// class DataQueue {
//   List goalList;
//   List<List> goalQueue = [[], [], [], [], [], [], []];
//   List<MetricsData> metricsQueue = [];

//   MetricsData m0 = MetricsData(
//     numSTcompleted: 0,
//     numShortGoals: 0,
//     stCompletionPrcnt: 0,
//     totalLTprogress: 0,
//     totalDuration: 0,
//     numLongGoals: 0,
//     durationPrcnt: 0,
//     numOverallCmplt: 0,
//     totalGoals: 0,
//     overallCmpltPrcnt: 0,
//     overallProgressPrcnt: 0,
//   );

//   DataQueue({required this.goalList});
// }

  ///initializes goals into Queue organize by date last 7 days
  // void goalListOrganizer() {
  //   goalList.sort((a, b) {
  //     return b.dateCreated
  //         .compareTo(a.dateCreated); //sorts list using dates ascending order
  //   });
  //   // goalList.sort();
  //   dynamic currentGoal;
  //   for (currentGoal in goalList) {
  //     DateTime goalDate = DateTime(currentGoal.goalCreationDate.year,
  //         currentGoal.goalCreationDate.month, currentGoal.goalCreationDate.day);
  //     if (currentGoal is LongTermGoal || currentGoal is Goal) {
  //       if (goalDate.isAtSameMomentAs(todaysDate)) {
  //         goalQueue[6].add(currentGoal);
  //       } else if ((currentGoal.isLongTerm == true) &
  //           (currentGoal.isCompleted == false)) {
  //         if (currentGoal.dateCreated.isBefore(todaysDate)) {
  //           goalQueue[6].add(currentGoal);
  //         }
  //       }

  //       if (goalDate
  //           .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 1)))) {
  //         goalQueue[5].add(currentGoal);
  //       } else if ((currentGoal.isLongTerm == true) &
  //           (currentGoal.isCompleted == false)) {
  //         if (currentGoal.dateCreated
  //             .isBefore(todaysDate.subtract(const Duration(days: 1)))) {
  //           goalQueue[5].add(currentGoal);
  //         }
  //       }

  //       if (goalDate
  //           .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 2)))) {
  //         goalQueue[4].add(currentGoal);
  //       } else if ((currentGoal.isLongTerm == true) &
  //           (currentGoal.isCompleted == false)) {
  //         if (currentGoal.dateCreated
  //             .isBefore(todaysDate.subtract(const Duration(days: 2)))) {
  //           goalQueue[4].add(currentGoal);
  //         }
  //       }

  //       if (goalDate
  //           .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 3)))) {
  //         goalQueue[3].add(currentGoal);
  //       } else if ((currentGoal.isLongTerm == true) &
  //           (currentGoal.isCompleted == false)) {
  //         if (currentGoal.dateCreated
  //             .isBefore(todaysDate.subtract(const Duration(days: 3)))) {
  //           goalQueue[3].add(currentGoal);
  //         }
  //       }

  //       if (goalDate
  //           .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 4)))) {
  //         goalQueue[2].add(currentGoal);
  //       } else if ((currentGoal.isLongTerm == true) &
  //           (currentGoal.isCompleted == false)) {
  //         if (currentGoal.dateCreated
  //             .isBefore(todaysDate.subtract(const Duration(days: 4)))) {
  //           goalQueue[2].add(currentGoal);
  //         }
  //       }

  //       if (goalDate
  //           .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 5)))) {
  //         goalQueue[1].add(currentGoal);
  //       } else if ((currentGoal.isLongTerm == true) &
  //           (currentGoal.isCompleted == false)) {
  //         if (currentGoal.dateCreated
  //             .isBefore(todaysDate.subtract(const Duration(days: 5)))) {
  //           goalQueue[1].add(currentGoal);
  //         }
  //       }

  //       if (goalDate
  //           .isAtSameMomentAs(todaysDate.subtract(const Duration(days: 6)))) {
  //         goalQueue[0].add(currentGoal);
  //       } else if ((currentGoal.isLongTerm == true) &
  //           (currentGoal.isCompleted == false)) {
  //         if (currentGoal.dateCreated
  //             .isBefore(todaysDate.subtract(const Duration(days: 6)))) {
  //           goalQueue[0].add(currentGoal);
  //         }
  //       }
  //     }
  //     print("Goal List accessed length =  ${goalList.length}");
  //   }
  //   //intializes days with no goals with 1 empty goal and calculates Metrics for each list of goals
  //   List listGoal;
  //   int i = 7;
  //   for (listGoal in goalQueue) {
  //     i--;

  //     currentMetrics = calcData(listGoal);
  //     currentMetrics.dataCollectionDate =
  //         todaysDate.subtract(Duration(days: i));
  //     currentMetrics.dayOfWeek =
  //         DateFormat('EEEE').format(todaysDate.subtract(Duration(days: i)));
  //     metricsQueue.add(currentMetrics);
  //   }
  // }

//   void mSize() {
//     if ((metricsQueue.length > 7) &
//         (metricsQueue[6]
//             .dataCollectionDate
//             .isAtSameMomentAs(currentMetrics.dataCollectionDate))) {
//       metricsQueue.removeAt(6);
//     } else if ((metricsQueue.length > 7) &
//         (metricsQueue[6]
//             .dataCollectionDate
//             .isBefore(currentMetrics.dataCollectionDate))) {
//       metricsQueue.removeAt(0);
//     }
//   }
// }

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

// List<MetricsData> metricsInitializer(DataQueue data) {
//   data.goalListOrganizer();
//   return data.metricsQueue;
// }

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
