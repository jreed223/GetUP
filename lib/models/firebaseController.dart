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
    final userAccount = await _db.collection('Users').doc(id);

    /// Saving the users information to the database.
    await userAccount.set({
      'email': email,
      'username': username,
      'fullname': fullname,
    });

    /// Creating the user's goals subcollection.
    /// This is done so that the user can add goals to their account.
    final userGoalsSubCollection = await userAccount.collection('goals');

    /// Adding the user's goals subcollection to the database.
    /// This field will be deleted when the user adds their first goal.
    await userGoalsSubCollection.add({
      'init': true,
    });
  }

  /// Adding a goal to the user's goals subcollection.
  static Future<void> pushGoal(Goal goal, bool isLongTerm, String id) async {
    final userGoalsSubCollection =
        await _db.collection('Users').doc(id).collection('goals');

    /// Adding the goal to the database.
    await userGoalsSubCollection.add({
      'title': goal.title,
      'duration': isLongTerm ? goal.goalDuration : 'N/A',
      'progress': isLongTerm ? goal.goalProgress : 'N/A',
      'completed': goal.isCompleted,
      'dateCreated': goal.dateCreated,
      'dateCompleted': goal.dateCompleted,
    });
  }
}
