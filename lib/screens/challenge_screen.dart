// Import the material package for the user interface widgets
import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getup_csc450/models/challenge.dart';


final dailyChallenge = DailyChallenge(title: 'Do something challenging', description: 'Challenge yourself to do something new and difficult every day');

final random = Random();
// Define a new stateful widget for the challenge screen
class ChallengeScreen extends StatefulWidget {
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

// Define the state for the challenge screen
class _ChallengeScreenState extends State<ChallengeScreen> {
  // Define two lists to keep track of the active and completed challenges
  List<DailyChallenge> activeChallenges = [];
  List<DailyChallenge> completedChallenges = [];
  late Timer timer;

  // Method to undo the completion of a challenge
  void undoChallengeCompletion(DailyChallenge challenge) {
    completedChallenges.remove(challenge);
    activeChallenges.add(challenge);
    // TODO: Save the changes to persistent storage
  }

  // The initState method is called when the widget is first created
  @override
  void initState() {
    super.initState();
    // Generate a new challenge when the widget is first created
    generateNewChallenge();
    // Set a timer to reset the completed challenges list every day at midnight
    timer = Timer.periodic(const Duration(days: 1), (timer) {
      setState(() {
        completedChallenges.clear();
      });
      // Generate a new challenge at the start of each day
      generateNewChallenge();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  // This method generates a new challenge and adds it to the active challenges list
  void generateNewChallenge() {
    // Only add a new challenge if there are no active challenges
    if (activeChallenges.isEmpty) {
      // Add the first challenge from the challenge list to the active challenges list
      
      setState(() {
        activeChallenges.add(dailyChallenge.sampleChallengeList[random.nextInt(dailyChallenge.sampleChallengeList.length)]);
      });
    }
  }

  // This method is called when the user completes a challenge
  void completeChallenge(DailyChallenge challenge) {
    setState(() {
      // Remove the completed challenge from the active challenges list
      activeChallenges.remove(challenge);
      // Add the completed challenge to the completed challenges list
      completedChallenges.add(challenge);
      // Generate a new challenge
      generateNewChallenge();
    });
  }

  // This method is called when the user requests a new challenge
  void requestNewChallenge() {
    setState(() {
      // Add the first challenge from the challenge list to the active challenges list
      activeChallenges.add(dailyChallenge.sampleChallengeList[random.nextInt(dailyChallenge.sampleChallengeList.length)]);
    });
  }

  // This method builds a list of challenges
  Widget buildChallengeList(List<DailyChallenge> challenges, bool isCompleted) {
    // If there are no challenges, display a message saying so
    if (challenges.isEmpty) {
      return const Text('You haven\'t completed any challenges yet today.');
    } else {
      // Otherwise, build a ListView of challenges with checkboxes to mark them as complete
      return ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (BuildContext context, int index) {
          final challenge = challenges[index];
          return ListTile(
            title: GestureDetector(
            child: Text(challenge.challengeTitle,
                  style: const TextStyle(color: Color.fromARGB(255, 255, 119, 0))),
            onTap: () {
              // Show the challenge description when the user taps on the title
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(challenge.challengeTitle),
                  content: Text(challenge.challengeDescription),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close',
                                        style: TextStyle(color: Color.fromARGB(255, 255, 119, 0)))
                    ),
                  ],
                ),
              );
            },
          ),
          
          trailing: isCompleted
              ? null  // Don't show the checkmark if the challenge is completed
              : Ink(
                  // decoration: BoxDecoration(
                  //   color: Colors.deepOrange,
                  //   shape: BoxShape.circle,
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.deepOrange.withOpacity(0.5),
                  //       blurRadius: 10,
                  //       offset: Offset(0, 5),
                  //     ),
                  //   ],
                  // ),
                  child: IconButton(
                      icon: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFD60A0),
                            Color(0xFFFB8B24),
                          ],
                        ).createShader(bounds),
                        child: const Icon(Icons.check, size: 28),
                      ),
                      color: Colors.white,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.white,
                      tooltip: 'Complete Challenge',
                      onPressed: () {
                        // Call the completeChallenge method when the user clicks the checkbox
                        completeChallenge(challenge);
                      },
                  ),
              ),
        );
      },
    );
  }
}
            

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // Define the app bar for the challenge screen
      appBar: AppBar(
        
        backgroundColor: Colors.grey[50],
        title: const Text(
          'Daily Challenges',
          style: TextStyle(
            color: Color.fromARGB(132, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          )
        ),
      ),
      // Define the body of the challenge screen
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the active challenges with a header
            const Text(
              'Active Challenges',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            // Build a list of active challenges
            Expanded(
              child: buildChallengeList(activeChallenges, false),
            ),
            const SizedBox(height: 16.0),
            // Display the completed challenges with a header
            const Text(
              'Completed Challenges',
              
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                          ),
            ),
            const SizedBox(height: 8.0),
            // Build a list of completed challenges
            Expanded(
              child: buildChallengeList(completedChallenges, true),
            ),
            const SizedBox(height: 16.0),
            // If all challenges have been completed, display a message with a button to request a new challenge
            if (completedChallenges.length == dailyChallenge.sampleChallengeList.length) ...[
              const Text('Congratulations! You have completed all challenges.'),
              ElevatedButton(
                onPressed: generateNewChallenge,
                child: const Text('Generate New Challenge'),
              ),
            ],
          ],
        ),
      ),
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
    return  MaterialApp(
      title: 'test',
      home: ChallengeScreen(),
    );
  }
}