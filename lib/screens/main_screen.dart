import 'package:flutter/material.dart';
import 'package:getup_csc450/models/profile_controller.dart';
import 'package:getup_csc450/widgets/home_screen_goal_card.dart';
import '../constants.dart';
import '../screens/home.dart';
import '../screens/metrics.dart';
import '../screens/profile.dart';

/// The Home screen widget.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The list of data to use for the item squares.
  final List<String> items = [
    'Scroll',
    'To',
    'The',
    'Right',
    'For',
    'As',
    'Long',
    'As',
    'There',
    'Exists',
    'Data',
    'To',
    'Be',
    'Stored',
    'In',
    'Here',
  ];

  @override
  initState() {
    super.initState();
    GOAL_STATES.loadGoalsFromFirebase();
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.purple,
              child: buildItemSquareList(items),
            ),
          ),
          const SizedBox(height: 10), // Add some space between the containers
          Expanded(
            child: Container(
              color: Colors.red,
              child: buildItemSquareList(items),
            ),
          ),
          const SizedBox(height: 10), // Add some space between the containers
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(1, 0, 0, 0),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: buildGoalCards(GOAL_STATES.longTermGoals),
            ),
          ),
        ],
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
  /// The profile to be used by the Profile screen.
  Profile profile = Profile.profiles[
      0]; // This exists to allow the nav bar to direct the user to the Profile screen when pressing the button
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
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const MetricsPage()), //Change to metrics screen
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

  /// The widget to build the item square list.
  Widget buildItemSquareList(List<String> items) {
    // Calculate the width of each item square based on the device screen size
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: itemWidth,
          height: itemWidth,
          margin: const EdgeInsets.all(8),
          color: Colors.white,
          child: Center(
            child: Text(
              items[index],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildGoalCards(List<dynamic> goals) {
  // List<LongTermGoal> longTermGoals = [];
  // for (var goal in goals) {
  //   if (goal is LongTermGoal) {
  //     longTermGoals.add(goal);
  //   }
  // }
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: goals.length,
      itemBuilder: (BuildContext context, int index) {
        try {
          return GeneralGoalCard(goal: goals[index]);
        } catch (e) {
          return Container();
        }
      });
}

// void main() {
//   runApp(const MaterialApp(
//     home: HomeScreen(),
//   ));
// }
