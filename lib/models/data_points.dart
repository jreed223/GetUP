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
List<MetricsData> currentMetrics = METRICS_QUEUE.getMetricsData();
DataQueue data = DataQueue();

/// this class represents one bar in a bar graph
class DataPoints {
  final String day; //weekday
  final double val;
  final double? val2; //overall percentage

  DataPoints({required this.day, required this.val, this.val2});
}

List<DataPoints> setLineData() {
  DataPoints lineData1 = DataPoints(
      day: currentMetrics[0].dayOfWeek, val: currentMetrics[0].totalGoals);
  DataPoints lineData2 = DataPoints(
      day: currentMetrics[1].dayOfWeek, val: currentMetrics[1].totalGoals);
  DataPoints lineData3 = DataPoints(
      day: currentMetrics[2].dayOfWeek, val: currentMetrics[2].totalGoals);
  DataPoints lineData4 = DataPoints(
      day: currentMetrics[3].dayOfWeek, val: currentMetrics[3].totalGoals);
  DataPoints lineData5 = DataPoints(
      day: currentMetrics[4].dayOfWeek, val: currentMetrics[4].totalGoals);
  DataPoints lineData6 = DataPoints(
      day: currentMetrics[5].dayOfWeek, val: currentMetrics[5].totalGoals);
  DataPoints lineData7 = DataPoints(
      day: currentMetrics[6].dayOfWeek, val: currentMetrics[6].totalGoals);
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

// List<DataPoints> setBarData(List<Goal> sampleList) {
//   DataPoints barData1 = DataPoints(
//       day: weeklyMetrics[0].dayOfWeek,
//       val: weeklyMetrics[0].completionPrcnt,
//       val2: weeklyMetrics[0].durationPrcnt);
//   DataPoints barData2 = DataPoints(
//       day: weeklyMetrics[1].dayOfWeek,
//       val: weeklyMetrics[1].completionPrcnt,
//       val2: weeklyMetrics[1].durationPrcnt);
//   DataPoints barData3 = DataPoints(
//       day: weeklyMetrics[2].dayOfWeek,
//       val: weeklyMetrics[2].completionPrcnt,
//       val2: weeklyMetrics[2].durationPrcnt);
//   DataPoints barData4 = DataPoints(
//       day: weeklyMetrics[3].dayOfWeek,
//       val: weeklyMetrics[3].completionPrcnt,
//       val2: weeklyMetrics[3].durationPrcnt);
//   DataPoints barData5 = DataPoints(
//       day: weeklyMetrics[4].dayOfWeek,
//       val: weeklyMetrics[4].completionPrcnt,
//       val2: weeklyMetrics[4].durationPrcnt);
//   DataPoints barData6 = DataPoints(
//       day: weeklyMetrics[5].dayOfWeek,
//       val: weeklyMetrics[5].completionPrcnt,
//       val2: weeklyMetrics[5].durationPrcnt);
//   DataPoints barData7 = DataPoints(
//       day: weeklyMetrics[6].dayOfWeek,
//       val: weeklyMetrics[6].completionPrcnt,
//       val2: weeklyMetrics[6].durationPrcnt);
//   return [barData1, barData2, barData3, barData4, barData5, barData6, barData7];
// }

// /// this class represents a single slice in a pie chart

// List<DataPoints> setPieData(List<Goal> sampleList) {
//   DataPoints pieData1 = DataPoints(
//       day: weeklyMetrics[0].dayOfWeek, val: weeklyMetrics[6].completionPrcnt);
//   DataPoints pieData2 = DataPoints(
//       day: weeklyMetrics[0].dayOfWeek, val: weeklyMetrics[6].completionPrcnt);
//   DataPoints pieData3 = DataPoints(
//       day: weeklyMetrics[0].dayOfWeek, val: weeklyMetrics[6].completionPrcnt);
//   DataPoints pieData4 = DataPoints(
//       day: weeklyMetrics[0].dayOfWeek, val: weeklyMetrics[6].completionPrcnt);
//   DataPoints pieData5 = DataPoints(
//       day: weeklyMetrics[0].dayOfWeek, val: weeklyMetrics[6].completionPrcnt);
//   DataPoints pieData6 = DataPoints(
//       day: weeklyMetrics[0].dayOfWeek, val: weeklyMetrics[6].completionPrcnt);
//   DataPoints pieData7 = DataPoints(
//       day: weeklyMetrics[0].dayOfWeek, val: weeklyMetrics[6].completionPrcnt);
//   return [pieData1, pieData2, pieData3, pieData4, pieData5, pieData6, pieData7];
// }
