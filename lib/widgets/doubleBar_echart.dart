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
  DoubleBarEchart({Key? key, required this.data}) : super(key: key);

  @override
  State<DoubleBarEchart> createState() => _DoubleBarEchartState();
}

class _DoubleBarEchartState extends State<DoubleBarEchart> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

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
    top: 20
  },
  tooltip: {
    position: 'top',
  },
  
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
  xAxis: { type: 'category',
  position: 'top' 
  },
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

  // Setting up Profile
  Profile profile = Profile.profiles[0];
  int _selectedIndex = 0;

  /// The function to call when a navigation bar item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MetricsPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(profile: profile)),
        );
        break;
    }
  }
}
