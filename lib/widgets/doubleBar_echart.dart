import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:getup_csc450/models/data_points.dart';

class DoubleBarEchart extends StatefulWidget {
  const DoubleBarEchart({super.key});

  @override
  State<DoubleBarEchart> createState() => _DoubleBarEchartState();
}

class _DoubleBarEchartState extends State<DoubleBarEchart> {
  var barData = setBarData();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Echarts(
        option: '''
{
  title: {
        left: 'center',
        top: 'top',
        text: 'Short-Term Goal Completion'
      },
  legend: {
    top: 30
  },
  tooltip: {},
  
  dataset: {
    source: [
      ['Date', 'Total Goals', 'Total Completed' ],
      ['${barData[0].day}', ${barData[0].val}, ${barData[0].val2}],
      ['${barData[1].day}', ${barData[1].val}, ${barData[0].val2}],
      ['${barData[2].day}', ${barData[2].val}, ${barData[0].val2}],
      ['${barData[3].day}', ${barData[3].val}, ${barData[0].val2}],
      ['${barData[4].day}', ${barData[4].val}, ${barData[0].val2}],
      ['${barData[5].day}', ${barData[5].val}, ${barData[0].val2}],
      ['${barData[6].day}', ${barData[6].val}, ${barData[0].val2}],
    ]
  },
  xAxis: { type: 'category' },
  yAxis: {
  },

  // Declare several bar series, each will be mapped
  // to a column of dataset.source by default.
  series: [{ 
    type: 'bar',  
    itemStyle: {
      color: '#F7AD19'
      }}, 
  { type: 'bar',
    itemStyle: {
      color: '#F27F0C'
      } 
  }]
}
  ''',
      ),
    );
  }
}
