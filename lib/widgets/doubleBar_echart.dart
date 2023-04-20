import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:getup_csc450/models/data_points.dart';

class DoubleBarEchart extends StatefulWidget {
  List<DataPoints> data;
  DoubleBarEchart({Key? key, required this.data}) : super(key: key);

  @override
  State<DoubleBarEchart> createState() => _DoubleBarEchartState();
}

class _DoubleBarEchartState extends State<DoubleBarEchart> {
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
      ['Date', 'Total Goals', 'Goals Completed' ],
      ['${widget.data[0].day}', ${widget.data[0].val}, ${widget.data[0].val2}],
      ['${widget.data[1].day}', ${widget.data[1].val}, ${widget.data[1].val2}],
      ['${widget.data[2].day}', ${widget.data[2].val}, ${widget.data[2].val2}],
      ['${widget.data[3].day}', ${widget.data[3].val}, ${widget.data[3].val2}],
      ['${widget.data[4].day}', ${widget.data[4].val}, ${widget.data[4].val2}],
      ['${widget.data[5].day}', ${widget.data[5].val}, ${widget.data[5].val2}],
      ['${widget.data[6].day}', ${widget.data[6].val}, ${widget.data[6].val2}],
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
