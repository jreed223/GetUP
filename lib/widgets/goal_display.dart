import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/widgets/goal_cards.dart';
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
              // TODO: Return different card based on goal type
              // TODO: Add complete button
              // TODO: Add edit button
              // TODO: Add a way to update progress for long term goals
              return !goals[index]['isLongTerm']
                  ? ShortTermGoalCard(
                      title: goals[index]['title'],
                      goalId: goals[index].reference.id)
                  : LongTermGoalCard(title: goals[index]['title']);
            },
          );
        });
  }
}
