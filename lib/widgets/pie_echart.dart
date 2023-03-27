import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class PieEchart extends StatefulWidget {
  const PieEchart({super.key});

  @override
  State<PieEchart> createState() => _PieEchartState();
}

class _PieEchartState extends State<PieEchart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      alignment: const Alignment(1, 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Echarts(
        option: '''
{
 
  tooltip: {
      trigger: 'item',
      position: 'left'
    },

  series: [
    {
      name: 'Goal Completion',
      type: 'pie',
      radius: ['55%', '85%'],
      avoidLabelOverlap: false,
      itemStyle: {
        borderRadius: 10,
        borderColor: '#fff',
        borderWidth: 2
      },
      label: {
        show: false,
        position: 'center'
      },
      emphasis: {
        label: {
          show: false,
          fontSize: 40,
          fontWeight: 'bold'
        }
      },
      labelLine: {
        show: false
      },
      data: [
        { value: 1048, name: 'Search Engine' },
        { value: 735, name: 'Direct' },
        { value: 580, name: 'Email' },
        { value: 484, name: 'Union Ads' },
        { value: 300, name: 'Video Ads' }
      ],
      left: '40%'
    }
  ]
}
  ''',
      ),
    );
  }
}
