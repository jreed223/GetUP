import 'package:charts_flutter/flutter.dart' as charts;

/// this class represents one bar in a bar graph
class BarData {
  final String date;
  final double numGoals;
  final charts.Color barColor;

  BarData(
    {required this.date, required this.numGoals, required this.barColor});
}


/// this class represents a single slice in a pie chart
class PieData {
  final int numGoalsCompleted;
  final int dateId;
  final charts.Color sliceColor;

  PieData(
    {required this.numGoalsCompleted, required this.dateId, required this.sliceColor});
}


/// this class represents a single point on the line graph
class LineData {
  final String date;
  final double numGoals;

  LineData(
    {required this.date, required this.numGoals});
}

