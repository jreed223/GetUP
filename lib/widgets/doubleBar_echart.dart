import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:getup_csc450/models/data_points.dart';
import 'package:provider/provider.dart';

import '../helpers/theme_provider.dart';
import '../models/profile_controller.dart';
import '../screens/home.dart';
import '../screens/main_screen.dart';
import '../screens/metrics.dart';
import '../screens/profile.dart';

class DoubleBarEchart extends StatefulWidget {
  List<DataPoints> data;

  //bool isDarkMode;

  late String chartTextColor;

  DoubleBarEchart({Key? key, required this.data}) : super(key: key);

  @override
  State<DoubleBarEchart> createState() => _DoubleBarEchartState();
}

class _DoubleBarEchartState extends State<DoubleBarEchart> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    if (themeProvider.isDarkMode) {
      widget.chartTextColor = "#FFFFFF";
    } else {
      widget.chartTextColor = "#000000";
    }

    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.9,
      child: Echarts(
        option: '''
{
  title: {
        left: 'center',
        top: 'top',
        text: 'Short-Term Goal Completion',
        textStyle: {
      color: '${widget.chartTextColor}',
      fontFamily: 'serif'

    }
      },
  legend: {
    top: 25,
    textStyle: {
      color: '${widget.chartTextColor}',
      fontFamily: 'serif'
    }
  },
  tooltip: {
    
    
  },
  grid: {
    left: 30,
    bottom: 25,
    right: 15
  },
  

  xAxis: [{ type: 'category',
  position: 'bottom',
    data: ['${widget.data[0].day}',
'${widget.data[1].day}',
'${widget.data[2].day}',
'${widget.data[3].day}',
'${widget.data[4].day}',
'${widget.data[5].day}',
{value: '${widget.data[6].day}', 
      textStyle: {
        color: '${widget.chartTextColor}'
      }
      }],
        
        
  }],
  yAxis: [{
    type: 'value'
  },
  {
    type: 'value'
  }],

  // Declare several bar series, each will be mapped
  // to a column of dataset.source by default.
  series: [{ 
    name: 'Total Goals',
    data : [ ${widget.data[0].val},
 ${widget.data[1].val},
 ${widget.data[2].val},
 ${widget.data[3].val},
 ${widget.data[4].val},
 ${widget.data[5].val},
 ${widget.data[6].val}],
    type: 'bar',  
 itemStyle: {
      color: '#F7AD19'
      }
      },
  { name: 'ST Goals Completed',
  data : [ ${widget.data[0].val2},
       ${widget.data[1].val2},
       ${widget.data[2].val2},
       ${widget.data[3].val2},
       ${widget.data[4].val2},
       ${widget.data[5].val2},
       ${widget.data[6].val2}],
    type: 'bar',
      itemStyle: {
      color: '#F27F0C'
      }, 
  }]
}
  ''',
      ),
    );
  }
}
