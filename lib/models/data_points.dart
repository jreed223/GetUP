import 'package:charts_flutter/flutter.dart' as charts;

//this class repreents one bar in a bar graph
class BarData {
  final String date;
  final double numGoals;
  final charts.Color barColor;

  BarData(
    {required this.date, required this.numGoals, required this.barColor});
}

class PieData {
  final int numGoalsCompleted;
  final int dateId;
  final charts.Color sliceColor;

  PieData(
    {required this.numGoalsCompleted, required this.dateId, required this.sliceColor});
}

class LineData {
  final String date;
  final double numGoals;

  LineData(
    {required this.date, required this.numGoals});
}

