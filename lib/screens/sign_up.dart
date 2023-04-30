import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/helpers/theme_provider.dart';
import 'package:getup_csc450/screens/login.dart';
import 'package:provider/provider.dart';

void main() => runApp(const SignupPage());

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _createAccountWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() != true) {
      return; // If the form is not valid, do not create an account
    }
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentReference userDocRef =
          firestore.collection('Users').doc(userCredential.user?.uid);

      await userDocRef.set({'fullname': firstNameController.text});

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occured')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        backgroundColor: themeProvider.scaffoldColor,
        body: Center(
            child: (Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                      text: const TextSpan(
                          text: 'It\'s Time to GET UP!',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PT-Serif')),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Create an Account',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          fontFamily: 'PT-Serif'),
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Name',
                          labelStyle: const TextStyle(
                              fontFamily: 'PT-Serif', color: Colors.black54),
                          prefixIcon: const Icon(Icons.abc_rounded)),
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Username',
                          labelStyle: const TextStyle(
                              fontFamily: 'PT-Serif', color: Colors.black54),
                          prefixIcon: const Icon(Icons.handshake_rounded)),
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Email Address',
                          labelStyle: const TextStyle(
                              fontFamily: 'PT-Serif', color: Colors.black54),
                          prefixIcon: const Icon(Icons.mail_outline_rounded)),
                      validator: _validateEmail,
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              fontFamily: 'PT-Serif', color: Colors.black54),
                          hintText: 'Must be at least 6 characters',
                          hintStyle: const TextStyle(
                              fontFamily: 'PT-Serif', color: Colors.black54),
                          prefixIcon: const Icon(Icons.lock_outline_rounded)),
                      validator: _validatePassword,
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: passwordConfirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(
                              fontFamily: 'PT-Serif', color: Colors.black54),
                          prefixIcon: const Icon(Icons.lock_outline_rounded)),
                      validator: _validateConfirmPassword,
                    )),
                const SizedBox(height: 20),
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(children: <Widget>[
                      Positioned.fill(
                          child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[
                          Color.fromARGB(255, 255, 144, 39),
                          Color.fromARGB(255, 255, 144, 39),
                          Color.fromARGB(255, 255, 144, 39)
                        ])),
                      )),
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.fromLTRB(75, 30, 75, 30),
                              textStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PT-Serif',
                                  letterSpacing: 1.1)),
                          onPressed: _isLoading
                              ? null
                              : _createAccountWithEmailAndPassword,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Sign Up')),
                    ])),
                const SizedBox(height: 50),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const Text(
                      'Already have an account? Sign in.',
                      style: TextStyle(
                          fontFamily: 'PT-Serif',
                          color: Color.fromARGB(255, 255, 144, 39)),
                    ))
              ],
            ),
          ),
        ))));
  }
}
