import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreController {
  static final db = FirebaseFirestore.instance;

  static Future<void> createGoal(Map<String, dynamic> goal, String id) async {
    await db.collection('users').doc(id).update({
      'goals': FieldValue.arrayUnion([goal])
    });
  }
}
