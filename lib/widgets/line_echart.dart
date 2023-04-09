import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:getup_csc450/models/data_points.dart';

import '../models/goals.dart';

class LineEchart extends StatefulWidget {
  const LineEchart({super.key});

  @override
  State<LineEchart> createState() => _LineEchartState();
}

class _LineEchartState extends State<LineEchart> {
  @override
  Widget build(BuildContext context) {
    final List<Goal> _sampleGoalsM = [
      LongTermGoal(title: 'Learn Flutter', duration: 20),
      Goal(title: 'ijbib'),
      LongTermGoal(title: 'Read', duration: 5),
      Goal(title: 'Go to the gym'),
      LongTermGoal(title: 'Learn Dart', duration: 10),
      Goal(title: 'Go to the dentist'),
      LongTermGoal(title: 'Learn Python', duration: 15),
    ];

    //var lineData = setLineData();

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Echarts(
        ///${lineData.elementAt(0).val}
        option: '''
    {

      title: {
        left: 'center',
        top: 'top',
        text: 'Overall Progress'
      },
       tooltip: {
      trigger: 'axis'
    },

      xAxis: {
        type: 'category',
        data: ['Mon', 'Tues', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      },
      yAxis: {
        type: 'value',
      },
      series: [{
        data: [ 22,
        44, 
        55, 
        66, 
        77, 
        88, 
        90], 
        type: 'line',
        smooth: true
      }],

    }
  ''',
      ),
    );
  }
}
