import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:getup_csc450/helpers/theme_provider.dart';
import 'package:getup_csc450/models/metrics_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/goals.dart';
import '../models/metrics_queue.dart';

class GeneralMetricCard extends StatefulWidget {
  double data;
  String dataTitle;
  String dataContext;
  List? goalList;

  GeneralMetricCard(this.dataTitle, this.data, this.dataContext, {super.key});
  @override
  State<GeneralMetricCard> createState() => _GeneralMetricCardState();
}

class _GeneralMetricCardState extends State<GeneralMetricCard> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

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
      margin: const EdgeInsets.all(8.0),
      height: screen.displayWidth(context) / 4,
      width: screen.displayWidth(context) / 2,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Container(
            height: screen.displayWidth(context) / 7,
            child: FittedBox(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                              textAlign: TextAlign.center,
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
                    padding:
                        EdgeInsets.all(screen.displayHeight(context) * 0.0005),
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
                ]),
              ]),
            ),
          ),
        ),
        CircularPercentIndicator(
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
            radius: screen.displayWidth(context) * 0.122,
            lineWidth: 10,
            percent: widget.data,
            center: (widget.data.isNaN
                ? Text(
                    '0%',
                    style: TextStyle(
                        fontFamily: 'PT-Serif',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.textColor),
                  )
                : Text(
                    '${((widget.data) * 100).roundToDouble().toInt().toString()}%',
                    style: TextStyle(
                        fontFamily: 'PT-Serif',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.textColor),
                  )),
            backgroundColor: Colors.black54),
      ]),
    );
  }
}
