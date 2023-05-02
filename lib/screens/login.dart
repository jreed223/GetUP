import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getup_csc450/screens/main_screen.dart';
import 'package:getup_csc450/screens/sign_up.dart';

void main() => runApp(const LoginPage());

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = '';
  String _password = '';
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isPasswordHidden = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _staySignedIn = false;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  void _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid email and/or password'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Card(
                              elevation: 5,
                              color: const Color.fromARGB(255, 255, 247, 244)
                                  .withOpacity(0.4),
                              child: Container(
                                  width: 600,
                                  padding: const EdgeInsets.fromLTRB(
                                      30, 200, 30, 200),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RichText(
                                          text: const TextSpan(
                                              text: 'Welcome to',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'PT-Serif')),
                                        ),
                                        RichText(
                                            text: const TextSpan(
                                                text: 'Get UP!',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'PT-Serif'))),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Please sign in to continue',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'PT-Serif'),
                                        ),
                                        const SizedBox(
                                          height: 60,
                                        ),
                                        TextFormField(
                                          controller: _emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              labelText: 'Email',
                                              labelStyle: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'PT-Serif'),
                                              prefixIcon: const Icon(
                                                  Icons.email_outlined)),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please enter your email';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            _email = value;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText: _isPasswordHidden,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            labelText: 'Password',
                                            labelStyle: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'PT-Serif'),
                                            prefixIcon: const Icon(
                                                Icons.lock_outline_rounded),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _isPasswordHidden
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed:
                                                  _togglePasswordVisibility,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please enter a password';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            _password = value;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Stack(children: <Widget>[
                                              Positioned.fill(
                                                  child: Container(
                                                decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: <Color>[
                                                      Color.fromARGB(
                                                          255, 255, 144, 39),
                                                      Color.fromARGB(
                                                          255, 255, 144, 39),
                                                      Color.fromARGB(
                                                          255, 255, 144, 39)
                                                    ])),
                                              )),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor: Colors
                                                          .white,
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          75, 30, 75, 30),
                                                      textStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'PT-Serif',
                                                              letterSpacing:
                                                                  1.25)),
                                                  onPressed: _isLoading
                                                      ? null
                                                      : _signInWithEmailAndPassword,
                                                  child: _isLoading
                                                      ? const CircularProgressIndicator()
                                                      : const Text('Login')),
                                            ])),
                                        const SizedBox(height: 40),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return const SignupPage();
                                              }));
                                            },
                                            child: const Text(
                                              'Don\'t have an account? Sign up.',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 144, 39),
                                                fontFamily: 'PT-Serif',
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                      ])))
                        ]))))));
  }
}
