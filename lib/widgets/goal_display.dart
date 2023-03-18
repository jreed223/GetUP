import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GoalView extends StatelessWidget {
  final String selectedDate;

  final goalsCollection = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('goals');
  GoalView({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: goalsCollection
            .where('dateCreated', isEqualTo: selectedDate)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var goals = snapshot.data!.docs;
          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(goals[index]['title']),
                ),
              );
            },
          );
        });
  }
}
