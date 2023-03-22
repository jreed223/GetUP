import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/models/goals.dart';
import 'metricsController.dart';

final List<Goal> _sampleGoalsM = [
  LongTermGoal(title: 'Learn Flutter', duration: '20'),
  Goal(title: 'Go to grocery store'),
  LongTermGoal(title: 'Read', duration: '5'),
  Goal(title: 'Go to the gym'),
  LongTermGoal(title: 'Learn Dart', duration: '10'),
  Goal(title: 'Go to the dentist'),
  LongTermGoal(title: 'Learn Python', duration: '15'),
];
final List<Goal> _sampleGoalsT = [
  LongTermGoal(title: 'Learn Flutter', duration: '20'),
  Goal(title: 'Go to grocery store'),
  LongTermGoal(title: 'Read', duration: '5'),
  Goal(title: 'Go to the gym'),
  LongTermGoal(title: 'Learn Dart', duration: '10'),
  Goal(title: 'Go to the dentist'),
  LongTermGoal(title: 'Learn Python', duration: '15'),
];
final List<Goal> _sampleGoalsW = [
  LongTermGoal(title: 'Learn Flutter', duration: '20'),
  Goal(title: 'Go to grocery store'),
  LongTermGoal(title: 'Read', duration: '5'),
  Goal(title: 'Go to the gym'),
  LongTermGoal(title: 'Learn Dart', duration: '10'),
  Goal(title: 'Go to the dentist'),
  LongTermGoal(title: 'Learn Python', duration: '15'),
];

var M1 = MetricsCalc(sampleList: _sampleGoalsM);
var M2 = M1.dailyData.overallProgressPrcnt;

var T1 = MetricsCalc(sampleList: _sampleGoalsT);
var T2 = T1.dailyData.overallProgressPrcnt;

var W1 = MetricsCalc(sampleList: _sampleGoalsW);
var W2 = W1.dailyData.overallProgressPrcnt;

class LineData {
  final List<LineChartBarData> lineChartBarData = [
    LineChartBarData(
      isCurved: true,
      spots: [
        FlSpot(1, M2),
        FlSpot(2, T2),
        FlSpot(3, W2),
        FlSpot(4, M2),
        FlSpot(5, T2),
        FlSpot(6, W2),
        FlSpot(7, M2),
      ],
    )
  ];
}

/// this class represents one bar in a bar graph
class BarData {
  final String xAxis; //weekday
  final double val; //overall percentage

  BarData({required this.xAxis, required this.val});
}

//overall progreess sample data
final sampleBarDataM = BarData(xAxis: 'Mon', val: M2);
final sampleBarDataT = BarData(xAxis: 'Tue', val: T2);
final sampleBarDataW = BarData(xAxis: 'Wed', val: W2);


// /// this class represents a single slice in a pie chart
// class PieData {
//   final double val; //% of goals comlpeted
//   final int dateId;
//   final charts.Color sliceColor;

//   PieData(
//       {required this.val,
//       required this.dateId,
//       required this.sliceColor});
// }

// /// this class represents a single point on the line graph
// class LineData {
//   final String xAxis; //weekday
//   final double yAxis; //percentage
//   final double val; //overall percentage
//   final charts.Color barColor; 

//   LineData({required this.xAxis, required this.yAxis, required this.val, required this.barColor});
// }
