import 'package:flutter/foundation.dart';
import 'package:getup_csc450/constants.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:intl/intl.dart';
import 'metricsController.dart';

//import 'goal_organizer.dart';
import 'goals.dart';
import 'metrics_Queue.dart';

// final List _sampleGoalsM = [
//   LongTermGoal(
//     title: 'Learn Flutter',
//     duration: 20,
//   ),
//   Goal(title: 'ijbib'),
//   LongTermGoal(title: 'Read', duration: 5),
//   Goal(title: 'Go to the gym'),
//   LongTermGoal(title: 'Learn Dart', duration: 10),
//   Goal(title: 'Go to the dentist'),
//   LongTermGoal(title: 'Learn Python', duration: 15),
// ];
//List<MetricsData> weeklyMetrics = METRICS_QUEUE.getMetricsData();

/// this class represents one bar in a bar graph
class DataPoints {
  final String? day; //weekday
  final double val;
  final double? val2; //overall percentage

  DataPoints({this.day, required this.val, this.val2});
}

List<DataPoints> setLineData(List<MetricsData> weeklyMetrics) {
  DataPoints lineData1 = DataPoints(
      day: weeklyMetrics[0].dayOfWeek,
      val: weeklyMetrics[0].overallProgressPrcnt);
  DataPoints lineData2 = DataPoints(
      day: weeklyMetrics[1].dayOfWeek,
      val: weeklyMetrics[1].overallProgressPrcnt);
  DataPoints lineData3 = DataPoints(
      day: weeklyMetrics[2].dayOfWeek,
      val: weeklyMetrics[2].overallProgressPrcnt);
  DataPoints lineData4 = DataPoints(
      day: weeklyMetrics[3].dayOfWeek,
      val: weeklyMetrics[3].overallProgressPrcnt);
  DataPoints lineData5 = DataPoints(
      day: weeklyMetrics[4].dayOfWeek,
      val: weeklyMetrics[4].overallProgressPrcnt);
  DataPoints lineData6 = DataPoints(
      day: weeklyMetrics[5].dayOfWeek,
      val: weeklyMetrics[5].overallProgressPrcnt);
  DataPoints lineData7 = DataPoints(
      day: weeklyMetrics[6].dayOfWeek,
      val: weeklyMetrics[6].overallProgressPrcnt);
  return [
    lineData1,
    lineData2,
    lineData3,
    lineData4,
    lineData5,
    lineData6,
    lineData7
  ];
}

dynamic setPieData(goalList) {
  double totalLTduration = 0;
  double totalTimeDedicated = 0;
  List<String> pieDataset = [];
  String noProgress = '';
  if (goalList.isNotEmpty) {
    for (var goal in goalList) {
      if ((goal.isCompleted == false) & (goal.isLongTerm == true)) {
        totalLTduration = totalLTduration + goal.duration;
        totalTimeDedicated = totalTimeDedicated + goal.timeDedicated;
        if (goal.timeDedicated == 0) {
          noProgress = '$noProgress<br/>${goal.goalTitle}';
        }
        String data =
            "{value: ${double.parse((goal.goalTimeDedicated).toStringAsFixed(2))}, name:'${goal.goalTitle}'}";
        pieDataset.add(data);
      }
      // else if ((goal.isCompleted == true) & (goal.isLongTerm == true)) {

      //   if ((goal.goalCompletionDate?.isBefore(todaysDate)) &
      //       goal.goalCompletionDate
      //           ?.isAfter(todaysDate.subtract(const Duration(days: 7)))) {
      //     String data =
      //         "{value: ${double.parse((goal.goalTimeDedicated).toStringAsFixed(2))}, name:'${goal.goalTitle}'}";
      //     pieDataset.add(data);
      //   }
      // }
    }
  } else {
    pieDataset = ["{value: 0, name:'No Longterm data'}"];
  }

  double incompleteDuration = totalLTduration - totalTimeDedicated;

  return [pieDataset, totalTimeDedicated, incompleteDuration];
}

/// this class represents a single slice in a pie chart

List<DataPoints> setBarData(List<MetricsData> weeklyMetrics) {
  DataPoints barData1 = DataPoints(
      day: weeklyMetrics[0].dayOfWeek,
      val: weeklyMetrics[0].numShortGoals,
      val2: weeklyMetrics[0].numSTcompleted);
  DataPoints barData2 = DataPoints(
      day: weeklyMetrics[1].dayOfWeek,
      val: weeklyMetrics[1].numShortGoals,
      val2: weeklyMetrics[1].numSTcompleted);
  DataPoints barData3 = DataPoints(
      day: weeklyMetrics[2].dayOfWeek,
      val: weeklyMetrics[2].numShortGoals,
      val2: weeklyMetrics[2].numSTcompleted);
  DataPoints barData4 = DataPoints(
      day: weeklyMetrics[3].dayOfWeek,
      val: weeklyMetrics[3].numShortGoals,
      val2: weeklyMetrics[3].numSTcompleted);
  DataPoints barData5 = DataPoints(
      day: weeklyMetrics[4].dayOfWeek,
      val: weeklyMetrics[4].numShortGoals,
      val2: weeklyMetrics[4].numSTcompleted);
  DataPoints barData6 = DataPoints(
      day: weeklyMetrics[5].dayOfWeek,
      val: weeklyMetrics[5].numShortGoals,
      val2: weeklyMetrics[5].numSTcompleted);
  DataPoints barData7 = DataPoints(
      day: weeklyMetrics[6].dayOfWeek,
      val: weeklyMetrics[6].numShortGoals,
      val2: weeklyMetrics[6].numSTcompleted);
  return [barData1, barData2, barData3, barData4, barData5, barData6, barData7];
}
