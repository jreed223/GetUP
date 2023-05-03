import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/constants.dart';
import 'package:getup_csc450/widgets/challenge_cards.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:getup_csc450/models/challenge.dart';
import '../models/goals.dart';
import 'filter.dart';
import '../helpers/theme_provider.dart';


class ChallengeView extends StatelessWidget {
  /// This is the date that is passed in from the calendar view
  final String selectedDate;

  const ChallengeView({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<ChallengeDataState>(
      builder: (context, provider, child) {
        List<dynamic> filteredChallengesBySelectedDate = [];
        for (dynamic challenge in provider.challenges) {
          if (challenge.formattedCreationDate == selectedDate) {
            filteredChallengesBySelectedDate.add(challenge);
          }
        }
        var challenges = filteredChallengesBySelectedDate;

        if (challenges.isEmpty) {
          return Center(
            child: Text('No challenges for selected date',
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'PT-Serif',
                    color: themeProvider.textColor)),
          );
        }

        return ListView.builder(
            itemCount: challenges.length,
            itemBuilder: (context, index) {
              /// if the filter is set to all, display all goals
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'All') {
                return ChallengeCard(challenge: challenges[index]);
              }

              /// if the filter is set to completed, display only completed challenges
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Completed') {
                if (challenges[index].isCompleted == true) {
                  return ChallengeCard(challenge: challenges[index]);
                } else {
                  return Container();
                }
              }

              /// if the filter is set to incomplete, display only incomplete challenges
              if (Provider.of<FilterState>(context).getFilterSelection() ==
                  'Incomplete') {
                if (challenges[index].isCompleted == false) {
                  return ChallengeCard(challenge: challenges[index]);
                } else {
                  return Container();
                }
              }
            });
      },
    );
  }
}

