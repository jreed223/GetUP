import 'package:flutter/material.dart';
import 'package:getup_csc450/screens/metrics.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
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
          color: Colors.grey[200],
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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'test',
      home: MetricsPage(),
    );
  }
}
