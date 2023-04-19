import 'package:flutter/material.dart';
import 'package:getup_csc450/widgets/line_echart.dart';
import 'package:getup_csc450/widgets/pie_echart.dart';
import 'package:getup_csc450/widgets/doubleBar_echart.dart';
import 'package:getup_csc450/constants.dart';
import 'package:provider/provider.dart';

import '../models/data_points.dart';
import '../models/goals.dart';
import '../models/metrics_Queue.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GoalDataState>(builder: (context, provider, child) {
      MetricsQueue METRICS_QUEUE = MetricsQueue(provider.goals);
      List<DataPoints> lineData = setLineData(METRICS_QUEUE.getMetricsData());
      List<DataPoints> barData = setBarData(METRICS_QUEUE.getMetricsData());
      List pieData = setPieData(provider.goals);

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
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.width / 14,
                              horizontal:
                                  MediaQuery.of(context).size.width / 14),
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
                          child: const Text(
                            "You Have\n Completed\n 14 Goals\n the Last 30 Days",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3.5,
                          child: PieEchart(data: pieData),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DoubleBarEchart(data: barData),
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
}
