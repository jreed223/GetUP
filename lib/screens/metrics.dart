import 'package:flutter/material.dart';
import 'package:getup_csc450/widgets/line_echart.dart';
import 'package:getup_csc450/widgets/pie_echart.dart';
import 'package:getup_csc450/widgets/doubleBar_echart.dart';

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
        backgroundColor: const Color.fromARGB(255, 56, 123, 248),
        title: const Text('Daily Data'),
      ),
      body: Center(
        ///Laying text and button vertically on the page
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.5,
                        alignment: const Alignment(-.75, -.25),
                        child: const Text(
                          "You have\n completed\n 4/7 Goals",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.5,
                        ),
                      ),
                      const Positioned(
                        width: 400,
                        left: 90,
                        child: PieEchart(),
                      )
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
    );
  }
}
