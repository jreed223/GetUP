import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/models/data_points.dart';

class LineChartDisplay extends StatefulWidget {
  const LineChartDisplay({super.key});

  @override
  State<LineChartDisplay> createState() => _LineChartDisplayState();
}

class _LineChartDisplayState extends State<LineChartDisplay> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          minX: 1,
          minY: 0,
          maxX: 7,
          maxY: 100,
          lineBarsData: LineData().lineChartBarData),
    );
  }
}
