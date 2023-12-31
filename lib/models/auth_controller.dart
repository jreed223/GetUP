import 'package:firebase_auth/firebase_auth.dart';

/// This class is used to control the Firebase Authentication.
/// It is a singleton class, so only one instance of it can be created.
class AuthController {
  /// This is the only instance of the class.
  /// It is created when the class is first called.
  static final AuthController _mainInstance =
      AuthController._mainInstanceCreator();

  /// This is the FirebaseAuth instance.
  /// It is used to access the database.
  static final _auth = FirebaseAuth.instance;

  /// This is the constructor for the class.
  /// It is private, so it can only be called from within the class.
  AuthController._mainInstanceCreator();

  /// This is the factory constructor for the class.
  /// It is used to return the "main instance" of the class.
  factory AuthController() {
    return _mainInstance;
  }

  /// This method gets the current user.
  User? get getUser => _auth.currentUser;

  /// This method gets the current user's ID.
  get getUserId => _auth.currentUser!.uid;

  /// This method signs in a user with email and password.
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /// This method signs up a user with email and password.
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
