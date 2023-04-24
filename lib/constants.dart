import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:getup_csc450/models/challenge.dart';

/// This will hold the state of all the goals in the app
GoalDataState GOAL_STATES = GoalDataState.mainInstance;

/// This will hold the state of all the challenge in the app
ChallengeDataState CHALLENGE_STATES = ChallengeDataState.mainInstance;

