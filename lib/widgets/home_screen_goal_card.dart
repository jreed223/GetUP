import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/goals.dart';

class GeneralGoalCard extends StatefulWidget {
  final dynamic goal;
  const GeneralGoalCard({super.key, required this.goal});

  @override
  State<GeneralGoalCard> createState() => _GeneralGoalCardState();
}

class _GeneralGoalCardState extends State<GeneralGoalCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GoalDataState>(
      builder: (context, provider, child) {
        return Container(
            decoration: provider.getStatus(widget.goal.goalId) != null
                ? provider.getStatus(widget.goal.goalId)!
                    ? BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 219, 255, 222),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 244, 255, 245),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(20, 0, 0, 0),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                2, 2), // changes position of shadow
                          ),
                        ],
                      )
                    : BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 255, 230, 214),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 255, 242, 235),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(20, 0, 0, 0),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                2, 2), // changes position of shadow
                          ),
                        ],
                      )
                : null,
            margin: const EdgeInsets.all(8.0),
            height: screen.displayWidth(context) / 2,
            width: screen.displayWidth(context) / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                        screen.displayHeight(context) * 0.005,
                      ),
                      child: Text('${widget.goal.goalTitle}',
                          style: const TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PT-Serif',
                              color: Color.fromARGB(180, 0, 0, 0))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.goal.goalStatus
                          ? RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Status:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(180, 0, 0, 0),
                                          fontFamily: 'PT-Serif')),
                                  TextSpan(
                                    text: ' Completed',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'PT-Serif',
                                      color: Color.fromARGB(180, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Status:',
                                      style: TextStyle(
                                          fontFamily: 'PT-Serif',
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(180, 0, 0, 0))),
                                  TextSpan(
                                    text: ' In Progress',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'PT-Serif',
                                      color: Color.fromARGB(180, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          screen.displaySize(context).width * 0.03),
                      child: CircularPercentIndicator(
                          linearGradient: provider.getStatus(
                                      widget.goal.goalId as String) ==
                                  null
                              ? null
                              : provider
                                      .getStatus(widget.goal.goalId as String)!
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
                          percent: provider.getTimeDedicated(
                                          widget.goal.goalId as String) !=
                                      null &&
                                  provider.getDuration(widget.goal.goalId as String) !=
                                      null
                              ? provider.getTimeDedicated(
                                      widget.goal.goalId as String)! /
                                  provider.getDuration(widget.goal.goalId as String)!
                              : 0.0,
                          center: Text(
                            '${((provider.getTimeDedicated(widget.goal.goalId as String) ?? 0) / (provider.getDuration(widget.goal.goalId as String) ?? 1) * 100).toInt()}%',
                            style: const TextStyle(
                                fontFamily: 'PT-Serif',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(180, 0, 0, 0)),
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
