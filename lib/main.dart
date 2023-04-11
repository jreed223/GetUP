import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:getup_csc450/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:getup_csc450/models/profileController.dart';
import 'package:getup_csc450/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  Profile.createSampleData();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => GoalDataState.mainInstance,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out');
      } else {
        print('User is signed in');
      }
    });
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
            scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                color: Color.fromARGB(255, 189, 216, 255),
                fontSize: 30,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
              displayMedium: TextStyle(
                color: Color.fromARGB(255, 189, 216, 255),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            )),
        home: const LoginPage());
  }
}
