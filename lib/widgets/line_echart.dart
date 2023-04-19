import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:getup_csc450/models/data_points.dart';
import 'package:getup_csc450/models/metrics_Queue.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/goals.dart';

class LineEchart extends StatefulWidget {
  List<DataPoints> data;
  LineEchart({Key? key, required this.data}) : super(key: key);

  @override
  State<LineEchart> createState() => _LineEchartState();
}

class _LineEchartState extends State<LineEchart> {
  @override
  Widget build(BuildContext context) {
    // final List<Goal> _sampleGoalsM = [
    //   LongTermGoal(title: 'Learn Flutter', duration: 20),
    //   Goal(title: 'ijbib'),
    //   LongTermGoal(title: 'Read', duration: 5),
    //   Goal(title: 'Go to the gym'),
    //   LongTermGoal(title: 'Learn Dart', duration: 10),
    //   Goal(title: 'Go to the dentist'),
    //   LongTermGoal(title: 'Learn Python', duration: 15),
    // ];
    inspect(widget.data);

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
        data: ['${widget.data.elementAt(0).day}', 
        '${widget.data.elementAt(1).day}', 
        '${widget.data.elementAt(2).day}', 
        '${widget.data.elementAt(3).day}', 
        '${widget.data.elementAt(4).day}', 
        '${widget.data.elementAt(5).day}',
        '${widget.data.elementAt(6).day}']
      },
      yAxis: [{
        type: 'value',
        max: 100
      }],
      series: [{
        data: [ ${widget.data.elementAt(0).val},
        ${widget.data.elementAt(1).val}, 
        ${widget.data.elementAt(2).val}, 
        ${widget.data.elementAt(3).val}, 
        ${widget.data.elementAt(4).val}, 
        ${widget.data.elementAt(5).val}, 
        ${widget.data.elementAt(6).val}], 
        type: 'line',
        smooth: true,
        showSymbol: true,
        lineStyle: {
          color: '#F7AD19'
        }, 
        itemStyle: {
        color: '#FF7D02'
      }
      }],

    }
  ''',
      ),
    );
  }
}
