import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:getup_csc450/helpers/theme_provider.dart';
import 'package:getup_csc450/models/metrics_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/goals.dart';
import '../models/metrics_Queue.dart';

class GeneralMetricCard extends StatefulWidget {
  MetricsData todaysMetrics;
  GeneralMetricCard(
      this.todaysMetrics, this.dataTitle, this.data, this.dataContext,
      {super.key});
  double data;
  String dataTitle;
  String dataContext;

  @override
  State<GeneralMetricCard> createState() => _GeneralMetricCardState();
}

class _GeneralMetricCardState extends State<GeneralMetricCard> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<GoalDataState>(
      builder: (context, provider, child) {
        return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: themeProvider.incompleteCardBorderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
              color: themeProvider.incompleteCardColor,
              boxShadow: [
                BoxShadow(
                  color: themeProvider.shadowColor,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(2, 2), // changes position of shadow
                ),
              ],
            ),
            height: screen.displayWidth(context) / 3,
            width: screen.displayWidth(context) / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                        screen.displayHeight(context) * 0.0005,
                      ),
                      child: Container(
                        width: screen.displayWidth(context) / 2.2,
                        child: Expanded(
                          child: FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.scaleDown,
                            child: Text(widget.dataTitle,
                                style: TextStyle(
                                    letterSpacing: 1.5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PT-Serif',
                                    color: themeProvider.textColor)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screen.displayWidth(context) / 2.2,
                      padding: EdgeInsets.all(
                          screen.displayHeight(context) * 0.0005),
                      child: Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.dataContext,
                                    style: TextStyle(
                                        fontFamily: 'PT-Serif',
                                        fontWeight: FontWeight.bold,
                                        color: themeProvider.textColor)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          screen.displaySize(context).width * 0.03),
                      child: CircularPercentIndicator(
                          linearGradient: widget.data == 100
                              ? const LinearGradient(colors: [
                                  Colors.greenAccent,
                                  Colors.green,
                                ])
                              : const LinearGradient(colors: [
                                  Colors.orangeAccent,
                                  Colors.orange,
                                  Colors.deepOrangeAccent,
                                  Colors.deepOrange
                                ]),
                          curve: Curves.bounceInOut,
                          radius: screen.displayWidth(context) * 0.125,
                          lineWidth: 10,
                          percent: widget.data,
                          center: Text(
                            '${((widget.data)).roundToDouble().toInt()}%',
                            style: TextStyle(
                                fontFamily: 'PT-Serif',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.textColor),
                          ),
                          backgroundColor: Colors.black54),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
