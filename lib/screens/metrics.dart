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
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        color: Colors.orangeAccent,
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 14,
                            horizontal: MediaQuery.of(context).size.width / 14),
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 14,
                            horizontal: MediaQuery.of(context).size.width / 14),
                        child: const Text(
                          "You have\n completed\n 4/7 Goals",
                          textAlign: TextAlign.center,
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
    );
  }
}
