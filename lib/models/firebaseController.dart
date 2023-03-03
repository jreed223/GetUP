import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/models/goals.dart';

/// This class is used to control the Firestore database.
/// It is a singleton class, so only one instance of it can be created.

class FirestoreController {
  /// This is the only instance of the class.
  /// It is created when the class is first called.
  static final FirestoreController _mainInstance =
      FirestoreController._mainInstanceCreator();

  /// This is the Firestore database instance.
  /// It is used to access the database.
  static final _db = FirebaseFirestore.instance;

  /// This is the constructor for the class.
  /// It is private, so it can only be called from within the class.
  FirestoreController._mainInstanceCreator();

  /// This is the factory constructor for the class.
  /// It is used to return the "main instance" of the class.
  factory FirestoreController() {
    return _mainInstance;
  }

  /// This method saves the user's email, username, and fullname to the database.
  static Future<void> saveUserInfo(
      String email, String username, String fullname, String id) async {
    /// This is the user's account document in the database.
    final userAccount = _db.collection('Users').doc(id);

    /// Saving the users information to the database.
    await userAccount.set({
      'email': email,
      'username': username,
      'fullname': fullname,
    });
  }

  /// Adding a goal to the user's goals subcollection.
  static Future<void> pushGoal(Goal goal, bool isLongTerm, String id) async {
    final userCollection = _db.collection('Users').doc(id);

    final goals = userCollection.collection('goals').doc(goal.goalTitle);

    await goals.set(goal.toJson());
  }
}
