import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:getup_csc450/models/data_points.dart';

class LineEchart extends StatefulWidget {
  const LineEchart({super.key});

  @override
  State<LineEchart> createState() => _LineEchartState();
}

class _LineEchartState extends State<LineEchart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: 300,
      height: MediaQuery.of(context).size.height / 4.5,
      child: Echarts(
        ///
        option: '''
    {

      title: {
        left: 'center',
        top: 'top',
        text: 'Overall Progress'
      },
      xAxis: {
        type: 'category',
        data: ['Mon', 'Tues', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      },
      yAxis: {
        type: 'value'
      },
      series: [{
        data: [23, 46, 52, 63, 81, 76, 98], 
        type: 'line',
        smooth: true
      }],

    }
  ''',
      ),
    );
  }
}
