import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:getup_csc450/constants.dart';
import 'package:getup_csc450/helpers/theme_provider.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:getup_csc450/models/metrics_queue.dart';
import 'package:getup_csc450/screens/main_screen.dart';
import 'package:getup_csc450/widgets/challenge_cards.dart';
import 'package:getup_csc450/widgets/filter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:getup_csc450/models/profile_controller.dart';
import 'package:getup_csc450/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getup_csc450/models/challenge.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _loadSavedTheme(ThemeProvider themeProvider) async {
  final prefs = await SharedPreferences.getInstance();
  final isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
  themeProvider.toggleTheme(isDarkTheme);
}


void main() async {
  Profile.createSampleData();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final themeProvider = ThemeProvider();
  await _loadSavedTheme(themeProvider);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GoalDataState>(
          create: (context) => GoalDataState(),
        ),
        ChangeNotifierProvider<ChallengeDataState>(
          create: (context) => ChallengeDataState(),
        ),
        ChangeNotifierProvider<FilterState>(
          create: (context) => FilterState(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  late ThemeProvider _themeProvider;
  @override
  void initState() {
    super.initState();
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
      } else {}
    });
    Provider.of<GoalDataState>(context, listen: false).loadGoalsFromFirebase();
    List initGoals = GOAL_STATES.goals;
    MetricsQueue().setMetricsQ(initGoals);
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                color: Color.fromARGB(255, 189, 216, 255),
                fontSize: 22,
                fontFamily: 'PT-Serif',
                fontWeight: FontWeight.bold,
              ),
              displayMedium: TextStyle(
                color: Color.fromARGB(255, 189, 216, 255),
                fontSize: 15,
                fontFamily: 'PT-Serif',
                fontWeight: FontWeight.bold,
              ),
            )),
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginPage()
            : const HomeScreen());
  }
}
