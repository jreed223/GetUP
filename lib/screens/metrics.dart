import 'package:flutter/material.dart';
import 'package:getup_csc450/widgets/line_echart.dart';
import 'package:getup_csc450/widgets/pie_echart.dart';
import 'package:getup_csc450/widgets/doubleBar_echart.dart';
import '../screens/home.dart';
import '../screens/metrics.dart';
import 'package:getup_csc450/models/profileController.dart';
import '../screens/profile.dart';
import '../screens/main_screen.dart';


class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  int num = 0;

  ///Used to increase number and set new state
  void incrementNum() {
    setState(() {
      num++;
    });
  }

  ///Used to decrease number and set new state
  void decrementNum() {
    setState(() {
      num = num - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                children: const [
                  Expanded(
                    child: LineEchart(),
                  ),
                ],
              ),

              ///This lays the button side by side
              Row(
                ///Centers row horizontally on x axis
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.orangeAccent,
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 14,
                            horizontal: MediaQuery.of(context).size.width / 14),
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 14,
                            horizontal: MediaQuery.of(context).size.width / 14),
                        alignment: const Alignment(0, -.15),
                        child: const Text(
                          "You have\n completed\n 4/7 Goals",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.5,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: const PieEchart(),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: DoubleBarEchart(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
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
  }

// Setting up Profile
Profile profile = Profile.profiles[
      0];
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
          MaterialPageRoute(
              builder: (context) => MetricsPage()),
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
