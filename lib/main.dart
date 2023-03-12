import 'package:flutter/material.dart';
import 'package:getup_csc450/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF222233),
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
      home: const HomePage(),
    );
  }
}

