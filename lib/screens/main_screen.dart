import 'package:flutter/material.dart';
import 'package:getup_csc450/models/profileController.dart';
import '../screens/home.dart';
import '../screens/metrics.dart';
import '../screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define a list of data to use for the item squares
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

  Profile profile = Profile.profiles[
      0]; // This exists to allow the nav bar to direct the user to the Profile screen when pressing the button

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
              color: Colors.pink,
              child: buildItemSquareList(items),
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

  int _selectedIndex = 0;

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
              builder: (context) => MetricsPage()), //Change to metrics screen
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

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'test',
//       home: HomeScreen(),
//     );
//   }
// }

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
