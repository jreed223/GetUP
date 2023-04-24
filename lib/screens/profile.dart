import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/theme_provider.dart';
import '../models/profile_controller.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/home.dart';
import '../screens/metrics.dart';
import '../screens/main_screen.dart';

/// The [ProfileScreen] widget displays the user's profile information and allows them to edit their bio and interests.
class ProfileScreen extends StatefulWidget {
  final Profile profile;

  const ProfileScreen({super.key, required this.profile});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

/// Creates a new [ProfileScreen] widget with the given [profile].
class _ProfileScreenState extends State<ProfileScreen> {
  // allows editable bio and interest
  late TextEditingController _bioController;
  late TextEditingController _interestsController;
  // setting of the themes which can be changed
  // ThemeData _currentTheme = Themes.lightTheme;

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
                    final themeProvider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    themeProvider.toggleTheme(false);
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Dark Theme'),
                onTap: () {
                  setState(() {
                    final themeProvider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    themeProvider.toggleTheme(true);
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
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        backgroundColor: themeProvider.scaffoldColor,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: themeProvider.scaffoldColor,
          title: Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'PT-Serif',
              color: themeProvider.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              letterSpacing: 1.5),
        ),
          actions: [
            IconButton(
              icon: const Icon(Icons.color_lens),
              color: themeProvider.buttonColor,
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
          style: TextStyle(
              fontFamily: 'PT-Serif',
              color: themeProvider.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              ),
            ),
              const SizedBox(height: 20.0), // Space below name
          Text(
          'About', // User's bio
          style: TextStyle(
              fontFamily: 'PT-Serif',
              color: themeProvider.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              ),
            ),
              TextField(
                controller: _bioController,
                decoration: InputDecoration(
                  hintText: 'Write your bio!',
                  hintStyle: TextStyle(
                    color: themeProvider.textColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeProvider.textColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeProvider.textColor,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: themeProvider.textColor,
                  fontFamily: "PT-Serif"
                ),
              ),
              const SizedBox(height: 20.0), // Space below bio
              Text(
                'Interests:', // User interests
                style: TextStyle(
                  color: themeProvider.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              TextField(
                controller: _interestsController,
                decoration: InputDecoration(
                  hintText: 'Add your interests here!',
                  hintStyle: TextStyle(
                    color: themeProvider.textColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeProvider.textColor
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeProvider.textColor,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: themeProvider.textColor,
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
                    backgroundColor: const Color.fromARGB(106, 172, 51, 51),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: themeProvider.scaffoldColor,
          selectedItemColor: themeProvider.buttonColor,
          unselectedItemColor: themeProvider.textColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Metrics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
    );
  }

// Setting up Profile
  Profile profile = Profile.profiles[0];
  int _selectedIndex = 0;

  /// The function to call when a navigation bar item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MetricsPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(profile: profile)),
        );
        break;
    }
  }
}

// void main() {
//   // Create sample data for testing
//   Profile.createSampleData();

//   // Get the first profile from the list of profiles
//   Profile profile = Profile.profiles[0];

//   // Run the app and display the ProfileScreen with the sample data
//   runApp(
//     MaterialApp(
//       home: ProfileScreen(profile: profile),
//     ),
//   );
// }
