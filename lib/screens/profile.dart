import 'package:flutter/material.dart';
import '../models/userController.dart';
import '../models/profileController.dart';

class ProfileScreen extends StatelessWidget {
  final Profile profile;

  ProfileScreen({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display user's name
            Text(
              '${profile.user.firstName} ${profile.user.lastName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 20.0), // Space below name
            const Text(
              'About:', // User bio
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Text(
              profile.userBio, // Display the bio
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 20.0), // Space below bio
            const Text(
              'Interests:', // User interests
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Text(
              profile.userInterests, // Displaying user interests
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  // Create sample data for testing
  Profile.createSampleData();

  // Get the first profile from the list of profiles
  Profile profile = Profile.profiles[0];

  // Run the app and display the ProfileScreen with the sample data
  runApp(
    MaterialApp(
      home: ProfileScreen(profile: profile),
    ),
  );
}
