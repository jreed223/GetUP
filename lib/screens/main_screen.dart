import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/goal_animation.dart';
import 'package:getup_csc450/helpers/theme_provider.dart';
import 'package:getup_csc450/models/profile_controller.dart';
import 'package:getup_csc450/widgets/home_screen_goal_card.dart';
import 'package:provider/provider.dart';
import '../models/goals.dart';
import '../screens/home.dart';
import '../screens/metrics.dart';
import '../screens/profile.dart';
import 'package:getup_csc450/models/challenge.dart';
import 'package:getup_csc450/widgets/home_screen_challenge_card.dart';
import 'package:getup_csc450/helpers/challenge_animation.dart';
import 'dart:async';

/// The Home screen widget.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;

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
    Provider.of<GoalDataState>(context, listen: false).loadGoalsFromFirebase();
    Provider.of<ChallengeDataState>(context, listen: false)
        .loadChallengeFromFirebase();

    // Generate a new challenge when the widget is first created
    // Generate a new challenge if the list is empty
    if (challengeDataState.challengesShown.isEmpty) {
      challenge.generateNewChallenges();
    }
    // Set a timer to reset the completed challenges list every day at midnight
    timer = Timer.periodic(const Duration(days: 1), (timer) {
      setState(() {
        Challenge chal;
        for (chal in challengeDataState.challengesShown) {
          challengeDataState.deleteChallengeShown(chal.challengeId);
        }
      });
      // Generate a new challenge at the start of each day
      challenge.generateNewChallenges();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: themeProvider.scaffoldColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: TextStyle(
              fontFamily: 'PT-Serif',
              color: themeProvider.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              letterSpacing: 1.5),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(),
              child: buildItemSquareList(items),
            ),
          ),
          const SizedBox(height: 10), // Add some space between the containers
          Expanded(
            child: Container(
              decoration: BoxDecoration(),
              child: buildChallengeCards(),
            ),
          ),
          const SizedBox(height: 10), // Add some space between the containers
          Expanded(
            child: Container(
              decoration: BoxDecoration(),
              child: buildGoalCards(),
            ),
          ),
        ],
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

Widget buildGoalCards() {
  return Consumer<GoalDataState>(
    builder:
        (BuildContext context, GoalDataState goalDataState, Widget? child) {
      List<dynamic> goals = goalDataState.longTermGoals;
      if (goals.length == 0) {
        return Center(
            child: Text('No long term goals have been created',
                style: TextStyle(
                  fontFamily: 'PT-Serif',
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Provider.of<ThemeProvider>(context).textColor,
                )));
      }
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: goals.length,
        itemBuilder: (BuildContext context, int index) {
          try {
            if (goals.length == 0) {
              return const Text('No goals');
            }
            return GoalAnimation(
                goalCard: GeneralGoalCard(goal: goals[index]),
                goal: goals[index]);
          } catch (e) {
            return null;
          }
        },
      );
    },
  );
}

Widget buildChallengeCards() {
  return Consumer<ChallengeDataState>(
    builder: (BuildContext context, ChallengeDataState challengeDataState,
        Widget? child) {
      List<Challenge> challenges = challengeDataState.challengesShown;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: challenges.length,
        itemBuilder: (BuildContext context, int index) {
          try {
            if (challenges.length == 0) {
              return const Text('No challenges');
            }
            return ChallengeAnimation(
                challengeShown: ChallengeShown(challenge: challenges[index]),
                challenge: challenges[index]);
          } catch (e) {
            return null;
          }
        },
      );
    },
  );
}


// void main() {
//   runApp(const MaterialApp(
//     home: HomeScreen(),
//   ));
// }
