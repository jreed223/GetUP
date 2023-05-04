// Import the material package for the user interface widgets
import 'dart:math';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/models/challenge.dart';
import 'package:getup_csc450/helpers/theme_provider.dart';
import 'package:getup_csc450/helpers/screen_size.dart' as screen;

final random = Random();
final challenge = Challenge(
    title: 'Do something challenging',
    description:
        'Challenge yourself to do something new and difficult every day');

List<Challenge> myChallenges = Challenge(
        title: 'Do something challenging',
        description:
            'Challenge yourself to do something new and difficult every day')
    .challengeList;

ChallengeDataState challengeDataState = ChallengeDataState();

// Define a new stateful widget for the challenge screen
class ChallengeShown extends StatefulWidget {
  final Challenge challenge;

  ChallengeShown({super.key, required this.challenge});
  // const ChallengeShown({super.key});

  @override
  _ChallengeShownState createState() => _ChallengeShownState();
}

// Define the state for the challenge screen
class _ChallengeShownState extends State<ChallengeShown> {
  //late Timer timer;
  // bool isAccepted = false;

  // The initState method is called when the widget is first created
  @override
  void initState() {
    super.initState();
    // // Generate a new challenge when the widget is first created
    // // Generate a new challenge if the list is empty
    // if (challengeDataState.challengesShown.isEmpty) {
    //     challenge.generateNewChallenges();
    // }
    // // Set a timer to reset the completed challenges list every day at midnight
    // timer = Timer.periodic(const Duration(days: 1), (timer) {
    //   setState(() {
    //     Challenge chal;
    //     for (chal in challengeDataState.challengesShown) {
    //       challengeDataState.deleteChallengeShown(chal.challengeId);}
    //   });
    //   // Generate a new challenge at the start of each day
    //   challenge.generateNewChallenges();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    //timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<ChallengeDataState>(
      builder: (context, provider, child) {
        return Container(
          height: screen.displayWidth(context) / 2,
          width: screen.displayWidth(context) / 2,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.challenge.isAccepted
                  ? themeProvider.completeCardBorderColor
                  : themeProvider.incompleteCardBorderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
            color: widget.challenge.isAccepted
                ? themeProvider.completeCardColor
                : themeProvider.incompleteCardColor,
            boxShadow: [
              BoxShadow(
                color: themeProvider.shadowColor,
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          margin: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screen.displayWidth(context) / 10,
                      child: Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(
                            screen.displayHeight(context) * 0.0005,
                          ),
                          child: Text(
                            '${widget.challenge.challengeTitle}',
                            style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PT-Serif',
                              color: themeProvider.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.challenge.isAccepted
                            ? RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Status:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: themeProvider.textColor,
                                        fontFamily: 'PT-Serif',
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Accepted',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'PT-Serif',
                                        color: themeProvider.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        screen.displayHeight(context) *
                                            0.000000001,
                                      ),
                                      child: Text(
                                        'Description:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'PT-Serif',
                                          fontSize: 13,
                                          color: themeProvider.textColor,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          screen.displayHeight(context) *
                                              0.00001,
                                        ),
                                        child: Text(
                                          '${widget.challenge.challengeDescription}',
                                          style: TextStyle(
                                            fontFamily: 'PT-Serif',
                                            fontSize: 12,
                                            color: themeProvider.textColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                        screen.displayHeight(context) * 0.0002,
                                      ),
                                      child: Visibility(
                                        visible: !widget.challenge.isAccepted,
                                        child: Expanded(
                                          child: MaterialButton(
                                            height:
                                                screen.displayWidth(context) /
                                                    15,
                                            onPressed: () {
                                              challengeDataState.addChallenge(
                                                  widget.challenge);
                                              setState(() {
                                                widget.challenge.isAccepted =
                                                    true;
                                              });
                                            },
                                            color: themeProvider.buttonColor,
                                            child: Text(
                                              'Accept',
                                              style: TextStyle(
                                                fontFamily: 'PT-Serif',
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
