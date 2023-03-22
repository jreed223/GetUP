import 'package:flutter/material.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  int num = 0;

  void incrementNum() {
    setState(() {
      num++;
    });
  }

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
        backgroundColor: Color.fromARGB(255, 56, 123, 248),
        title: Text('num Increment'),
      ),
      body: Center(
        ///Laying text and button vertically on the page
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///This passes a variable into the string
            Text("This is my number: $num"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => incrementNum(),
                  child: Icon(
                    Icons.add,
                    color: Colors.redAccent,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => decrementNum(),
                  child: Icon(
                    Icons.text_decrease,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
