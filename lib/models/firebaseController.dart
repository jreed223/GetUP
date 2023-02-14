import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<void> createGoal(Map<String, dynamic> goal, String id) async {
    await _db.collection('users').doc(id).update({
      'goals': FieldValue.arrayUnion([goal])
    });
  }
}
