import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class DoubleBarEchart extends StatefulWidget {
  const DoubleBarEchart({super.key});

  @override
  State<DoubleBarEchart> createState() => _DoubleBarEchartState();
}

class _DoubleBarEchartState extends State<DoubleBarEchart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      alignment: Alignment.centerRight,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Echarts(
        option: '''
{
  title: {
        left: 'center',
        top: 'top',
        text: 'Short-Term vs. Long-Term Progress'
      },
  legend: {
    top: 30
  },
  tooltip: {},
  
  dataset: {
    source: [
      ['Date', 'Short Term', 'Long Term' ],
      ['Sun', 43.3, 85.8],
      ['Mon', 83.1, 73.4],
      ['Tues', 86.4, 65.2],
      ['Wed', 72.4, 53.9],
      ['Thur', 42.4, 73.9],
      ['Fri', 62.4, 43.9],
      ['Sat', 32.4, 53.9,]
    ]
  },
  xAxis: { type: 'category' },
  yAxis: {
  },
  // Declare several bar series, each will be mapped
  // to a column of dataset.source by default.
  series: [{ type: 'bar' }, { type: 'bar' }]
}
  ''',
      ),
    );
  }
}
