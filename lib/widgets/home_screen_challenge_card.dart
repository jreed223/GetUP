// Import the material package for the user interface widgets
import 'dart:html';
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

List<Challenge> myChallenges = Challenge( title: 'Do something challenging', description: 'Challenge yourself to do something new and difficult every day').challengeList; 

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

  late Timer timer;



  // The initState method is called when the widget is first created
  @override
  void initState() {
    super.initState();
    // Generate a new challenge when the widget is first created
    // Generate a new challenge if the list is empty
    if (challengeDataState.challengesShown.isEmpty) {
        challenge.generateNewChallenges();
    }
    // Set a timer to reset the completed challenges list every day at midnight
    timer = Timer.periodic(const Duration(days: 1), (timer) {
      setState(() {
        Challenge chal;
        for (chal in challengeDataState.challengesShown) {
          challengeDataState.deleteChallengeShown(chal.challengeId);}
      });
      // Generate a new challenge at the start of each day
      challenge.generateNewChallenges();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print(challenge);
    bool isAccepted = false;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<ChallengeDataState>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isAccepted
                ? themeProvider.completeCardBorderColor
                : themeProvider.incompleteCardBorderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isAccepted
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      screen.displayHeight(context) * 0.005,
                    ),
                    child: Text(
                      '${widget.challenge.challengeTitle}',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PT-Serif',
                        color: themeProvider.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isAccepted
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
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                screen.displayHeight(context) * 0.01,
                              ),
                              child: Text(
                                'Description:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PT-Serif',
                                  fontSize: 20,
                                  color: themeProvider.textColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                screen.displayHeight(context) * 0.01,
                              ),
                              child: Text(
                                '${widget.challenge.challengeDescription}',
                                style: TextStyle(
                                  fontFamily: 'PT-Serif',
                                  fontSize: 16,
                                  color: themeProvider.textColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                screen.displayHeight(context) * 0.02,
                              ),
                              child: (Visibility(
                                visible: !isAccepted,
                                child: MaterialButton(
                                  onPressed: () {
                                    challengeDataState.addChallenge(widget.challenge);
                                    setState(() {
                                      isAccepted = true;
                                    });
                                  },
                                  color: themeProvider.buttonColor,
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      fontFamily: 'PT-Serif',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              ),
                            ),
                          ],
                        ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//   @override
//   Widget buildChallengeCards() {
//   return Consumer<ChallengeDataState>(
//     builder:
//         (BuildContext context, ChallengeDataState challengeDataState, Widget? child) {
//       List<Challenge> challenges = challengeDataState.challengesShown;
//       return ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: challenges.length,
//         itemBuilder: (BuildContext context, int index) {
//           try {
//             if (challenges.length == 0) {
//               return const Text('No challenges');
//             }
//             return GoalAnimation(
//                 goalCard: GeneralGoalCard(goal: challenges[index]),
//                 goal: challenges[index]);
//           } catch (e) {
//             return null;
//           }
//         },
//       );
//     },
//   );
// }



// class _GeneralGoalCardState extends State<GeneralGoalCard> {
//   @override
//   Widget build(BuildContext context) {
//     ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
//     return Consumer<GoalDataState>(
//       builder: (context, provider, child) {
//         return Container(
//             decoration: provider.getStatus(widget.goal.goalId) != null
//                 ? provider.getStatus(widget.goal.goalId)!
//                     ? BoxDecoration(
//                         border: Border.all(
//                           color: themeProvider.completeCardBorderColor,
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                         color: themeProvider.completeCardColor,
//                         boxShadow: [
//                           BoxShadow(
//                             color: themeProvider.shadowColor,
//                             spreadRadius: 2,
//                             blurRadius: 3,
//                             offset: const Offset(
//                                 2, 2), // changes position of shadow
//                           ),
//                         ],
//                       )
//                     : BoxDecoration(
//                         border: Border.all(
//                           color: themeProvider.incompleteCardBorderColor,
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                         color: themeProvider.incompleteCardColor,
//                         boxShadow: [
//                           BoxShadow(
//                             color: themeProvider.shadowColor,
//                             spreadRadius: 2,
//                             blurRadius: 3,
//                             offset: const Offset(
//                                 2, 2), // changes position of shadow
//                           ),
//                         ],
//                       )
//                 : null,
//             margin: const EdgeInsets.all(8.0),
//             height: screen.displayWidth(context) / 2,
//             width: screen.displayWidth(context) / 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(
//                         screen.displayHeight(context) * 0.005,
//                       ),
//                       child: Text('${widget.goal.goalTitle}',
//                           style: TextStyle(
//                               letterSpacing: 1.5,
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'PT-Serif',
//                               color: themeProvider.textColor)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: widget.goal.goalStatus
//                           ? RichText(
//                               text: TextSpan(
//                                 style: DefaultTextStyle.of(context).style,
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                       text: 'Status:',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: themeProvider.textColor,
//                                           fontFamily: 'PT-Serif')),
//                                   TextSpan(
//                                     text: ' Completed',
//                                     style: TextStyle(
//                                       fontStyle: FontStyle.italic,
//                                       fontFamily: 'PT-Serif',
//                                       color: themeProvider.textColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : RichText(
//                               text: TextSpan(
//                                 style: DefaultTextStyle.of(context).style,
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                       text: 'Status:',
//                                       style: TextStyle(
//                                           fontFamily: 'PT-Serif',
//                                           fontWeight: FontWeight.bold,
//                                           color: themeProvider.textColor)),
//                                   TextSpan(
//                                     text: ' In Progress',
//                                     style: TextStyle(
//                                       fontStyle: FontStyle.italic,
//                                       fontFamily: 'PT-Serif',
//                                       color: themeProvider.textColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(
//                           screen.displaySize(context).width * 0.03),
//                       child: CircularPercentIndicator(
//                           linearGradient: provider.getStatus(
//                                       widget.goal.goalId as String) ==
//                                   null
//                               ? null
//                               : provider
//                                       .getStatus(widget.goal.goalId as String)!
//                                   ? const LinearGradient(colors: [
//                                       Colors.greenAccent,
//                                       Colors.green,
//                                     ])
//                                   : const LinearGradient(colors: [
//                                       Colors.orangeAccent,
//                                       Colors.orange,
//                                       Colors.deepOrangeAccent,
//                                       Colors.deepOrange
//                                     ]),
//                           curve: Curves.bounceInOut,
//                           radius: screen.displayWidth(context) * 0.125,
//                           lineWidth: 10,
//                           percent: provider.getTimeDedicated(
//                                           widget.goal.goalId as String) !=
//                                       null &&
//                                   provider.getDuration(widget.goal.goalId as String) !=
//                                       null
//                               ? provider.getTimeDedicated(
//                                       widget.goal.goalId as String)! /
//                                   provider.getDuration(widget.goal.goalId as String)!
//                               : 0.0,
//                           center: Text(
//                             '${((provider.getTimeDedicated(widget.goal.goalId as String) ?? 0) / (provider.getDuration(widget.goal.goalId as String) ?? 1) * 100).roundToDouble().toInt()}%',
//                             style: TextStyle(
//                                 fontFamily: 'PT-Serif',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: themeProvider.textColor),
//                           ),
//                           backgroundColor: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ));
//       },
//     );
//   }
// }

// }