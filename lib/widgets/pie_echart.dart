import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:getup_csc450/models/data_points.dart';

class PieEchart extends StatefulWidget {
  List data;
  PieEchart({Key? key, required this.data}) : super(key: key);

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
      position: 'left',
      formatter: '{b}<br> {c} hours ({d}%)'

    },

  visualMap: {
    show: false,
    min: 60,
    max: 1000,
    inRange: {
      colorLightness: [.5, .85]
    }
    },

   title: {
    text: 'Long-Term Goal Progress',
    left: 10
  },
    

  series: [
    {
      name: 'Long Term Goal Completion',
      type: 'pie',
      radius: [0, '40%'],
      label: {
        show: false,
        position: 'inner',
      },
      labelLine: {
        show: false
      },
      data: [
        { value: ${double.parse(widget.data[1].toStringAsFixed(2))}, 
        name: 'Time Dedicated',
        itemStyle: {
        color: "#23C552"} 
      },
        { value: ${double.parse(widget.data[2].toStringAsFixed(2))}, 
        name: 'Time Remaining',
        itemStyle: {
        color: "#F84F31"} 
        },
      ],
      left: '46%'
    },
    {
      name: 'Long Term Goal Completion',
      type: 'pie',
      radius: ['55%', '85%'],
      avoidLabelOverlap: false,
      itemStyle: {
        color: '#F27F0C',
        borderRadius: 10,
        
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
      data: ${widget.data[0]},

      left: '46%'
    }
  ]
}
  ''',
      ),
    );
  }
}
