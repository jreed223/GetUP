import 'package:flutter/material.dart';
import '../models/userController.dart';
import '../models/profileController.dart';
import '../helpers/themes.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// The [ProfileScreen] widget displays the user's profile information and allows them to edit their bio and interests.
class ProfileScreen extends StatefulWidget {
  final Profile profile;

  ProfileScreen({required this.profile});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

/// Creates a new [ProfileScreen] widget with the given [profile].
class _ProfileScreenState extends State<ProfileScreen> {
  // allows editable bio and interest
  late TextEditingController _bioController;
  late TextEditingController _interestsController;
  // setting of the themes which can be changed
  ThemeData _currentTheme = Themes.lightTheme;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.profile.userBio);
    _interestsController =
        TextEditingController(text: widget.profile.userInterests);
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  @override
  void dispose() {
    _bioController.dispose();
    _interestsController.dispose();
    super.dispose();
  }

  /// Displays a menu allowing the user to select a new theme.
  void _showThemeMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: const Text('Light Theme'),
                onTap: () {
                  setState(() {
                    _currentTheme = Themes.lightTheme;
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Dark Theme'),
                onTap: () {
                  setState(() {
                    _currentTheme = Themes.darkTheme;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _currentTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              )),
          actions: [
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: () {
                _showThemeMenu(context);
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                decoration: InputDecoration(
                  hintText: 'Write your bio!',
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
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
                decoration: InputDecoration(
                  hintText: 'Add your interests here!',
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(106, 172, 51, 51),
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
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
