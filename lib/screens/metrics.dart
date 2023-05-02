import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getup_csc450/widgets/line_echart.dart';
import 'package:getup_csc450/widgets/pie_echart.dart';
import 'package:getup_csc450/widgets/doubleBar_echart.dart';
import '../helpers/theme_provider.dart';
import '../screens/home.dart';
import 'package:getup_csc450/models/profile_controller.dart';
import '../screens/profile.dart';
import '../screens/main_screen.dart';

import 'package:getup_csc450/constants.dart';
import 'package:provider/provider.dart';

import '../models/data_points.dart';
import '../models/goals.dart';
import '../models/metrics_Controller.dart';
import '../models/metrics_Queue.dart';
import 'package:text_scroll/text_scroll.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  List longTermGoals = [];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalDataState>(builder: (context, provider, child) {
      inspect(provider.goals);
      MetricsQueue METRICS_QUEUE = MetricsQueue(provider.goals);

      METRICS_QUEUE.setMetrics();
      List<DataPoints> lineData = setLineData(METRICS_QUEUE.currentMetricsQ);
      List<DataPoints> barData = setBarData(METRICS_QUEUE.currentMetricsQ);
      List pieData = setPieData(provider.goals);

      // for (MetricsData data in METRICS_QUEUE.getMetricsData()) {}

      // int secondCount = 0;
      // everySecond = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      //   secondCount += 1;
      //   if (secondCount == 5) {
      //     setState(() {
      //       i += 1;
      //       if (i > longTermGoals.length) {
      //         i = 0;
      //       }
      //     });
      //   }
      // });
      ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
      for (var goal in provider.getGoals()) {
        if (goal.isLongTerm) {
          longTermGoals.add(goal);
        }
      }
      if (longTermGoals.isEmpty) {}

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Daily Data'),
        ),
        body: Center(
          ///Laying text and button vertically on the page
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              //Centers column vertically on y axis
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: LineEchart(data: lineData),
                    ),
                  ],
                ),

                ///This lays the button side by side
                Row(
                  ///Centers row horizontally on x axis
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 3,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // padding: EdgeInsets.symmetric(
                          //     vertical: MediaQuery.of(context).size.width / 14,
                          //     horizontal:
                          //         MediaQuery.of(context).size.width / 14),
                          margin: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.width / 14,
                              horizontal:
                                  MediaQuery.of(context).size.width / 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.orangeAccent, width: 3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  child: TextScroll(
                                    fadedBorderWidth: .05,
                                    fadedBorder: true,
                                    pauseBetween: const Duration(seconds: 3),
                                    velocity: const Velocity(
                                        pixelsPerSecond: Offset(50, 0)),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'Open Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                    (longTermGoals.isNotEmpty
                                        ? "${longTermGoals[i].title}"
                                        : "No Long Term Data"),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.orangeAccent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Open Sans',
                                              fontSize: 30,
                                              fontWeight: FontWeight.w800,
                                            ),
                                            (longTermGoals.isNotEmpty
                                                ? "${double.parse((longTermGoals[i].duration - longTermGoals[i].timeDedicated).toStringAsFixed(2))}"
                                                : '0')),
                                        const Center(
                                          child: Text(
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600),
                                              "Hours\nRemain"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontFamily: 'Open Sans',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                      (longTermGoals.isNotEmpty
                                          ? "${(double.parse((longTermGoals[i].goalProgress * 100).toStringAsFixed(2)))}% Complete "
                                          : '')),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3.5,
                          child: PieEchart(data: pieData),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width / 3,
                          width: MediaQuery.of(context).size.width / 2.25,
                          child: GestureDetector(onTap: () {
                            setState(() {
                              i += 1;
                              if (i >= longTermGoals.length) {
                                i = 0;
                              }
                            });
                            print('Tapped Container');
                          }),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        DoubleBarEchart(data: barData),
                        Positioned(
                          bottom: 0,
                          height: MediaQuery.of(context).size.height / 13,
                          width: MediaQuery.of(context).size.width,
                          child: BottomNavigationBar(
                            elevation: 0,
                            type: BottomNavigationBarType.fixed,
                            backgroundColor: themeProvider.scaffoldColor,
                            selectedItemColor: themeProvider.textColor,
                            unselectedItemColor: themeProvider.textColor,
                            currentIndex: _selectedIndex,
                            onTap: _onItemTapped,
                            items: const [
                              BottomNavigationBarItem(
                                icon: Icon(Icons.home),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.calendar_today),
                                label: 'Calendar',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.analytics),
                                label: 'Metrics',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.person),
                                label: 'Profile',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
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
