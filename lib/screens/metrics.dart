import 'package:flutter/material.dart';
import 'package:getup_csc450/widgets/line_echart.dart';
import 'package:getup_csc450/widgets/pie_echart.dart';
import 'package:getup_csc450/widgets/doubleBar_echart.dart';
import '../helpers/theme_provider.dart';
import '../models/metrics_controller.dart';
import '../screens/home.dart';
import 'package:getup_csc450/models/profile_controller.dart';
import '../screens/profile.dart';
import '../screens/main_screen.dart';

import 'package:getup_csc450/constants.dart';
import 'package:provider/provider.dart';

import '../models/data_points.dart';
import '../models/goals.dart';
import '../models/metrics_queue.dart';
import 'package:text_scroll/text_scroll.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  List longTermGoals = [];
  int i = 0;
  //var chartTextColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalDataState>(builder: (context, provider, child) {
      List<MetricsData> metricsQueue = MetricsQueue().currentMetricsQ;

      List<DataPoints> lineData = setLineData(metricsQueue);
      List<DataPoints> barData = setBarData(metricsQueue);
      List pieData = setPieData(GOAL_STATES.longTermGoals);

      for (var goal in GOAL_STATES.goals) {
        if (goal.isLongTerm) {
          if(goal.isCompleted == false) {
            longTermGoals.add(goal);
          }else if(goal?.dateCompleted.isAfter( todaysDate.subtract(const Duration(days: 7)))){
            longTermGoals.add(goal);
          }
        }
      }

      ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

      return Scaffold(
        backgroundColor: themeProvider.scaffoldColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: themeProvider.scaffoldColor,
          title: Text('Daily Data',
              style: TextStyle(
                  color: themeProvider.textColor,
                  fontFamily: 'PT-Serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 1.5)),
        ),
        body: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
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
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 2.5,
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 14,
                            horizontal: MediaQuery.of(context).size.width / 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: longTermGoals[i].isCompleted
                                  ? themeProvider.buttonColor.withOpacity(0)
                                  : themeProvider.buttonColor,
                              width: 3),
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
                                  fadedBorder: false,
                                  pauseBetween: const Duration(seconds: 3),
                                  velocity: const Velocity(
                                      pixelsPerSecond: Offset(50, 0)),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: themeProvider.textColor,
                                      fontFamily: 'PT-Serif',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  (longTermGoals.isNotEmpty
                                      ? "${longTermGoals[i].title}"
                                      : "No Long Term Data"),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: longTermGoals[i].isCompleted
                                      ? BoxDecoration(
                                          gradient:
                                              themeProvider.completeGradient,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                        )
                                      : BoxDecoration(
                                          color: themeProvider.buttonColor),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          alignment: Alignment.centerRight,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PT-Serif',
                                                fontSize: 40,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              (longTermGoals.isNotEmpty
                                                  ? "${double.parse((longTermGoals[i].duration - longTermGoals[i].timeDedicated).toStringAsFixed(2))}"
                                                  : '0')),
                                        ),
                                      ),
                                      const Expanded(
                                        child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'PT-Serif',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                              "Hours\nRemain"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: themeProvider.textColor,
                                        fontFamily: 'PT-Serif',
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
                      Positioned(
                        left: MediaQuery.of(context).size.width / 20,
                        bottom: MediaQuery.of(context).size.width / 14,
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 2.5,
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
                  DoubleBarEchart(
                    data: barData,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: themeProvider.scaffoldColor,
          selectedItemColor: themeProvider.buttonColor,
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