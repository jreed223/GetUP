import 'package:flutter/material.dart';
import '../models/userController.dart';
import '../models/profileController.dart';

class ProfileScreen extends StatefulWidget {
  final Profile profile;

  ProfileScreen({required this.profile});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _bioController;
  late TextEditingController _interestsController;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.profile.userBio);
    _interestsController =
        TextEditingController(text: widget.profile.userInterests);
  }

  @override
  void dispose() {
    _bioController.dispose();
    _interestsController.dispose();
    super.dispose();
  }

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
              '${widget.profile.user.firstName} ${widget.profile.user.lastName}',
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
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                hintText: 'Write your bio!',
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
            TextField(
              controller: _interestsController,
              decoration: const InputDecoration(
                hintText: 'Add your interests here!',
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
