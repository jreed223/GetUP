import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:getup_csc450/models/metricsController.dart';
import 'package:getup_csc450/models/metrics_Queue.dart';

/// This will hold the state of all the goals in the app
GoalDataState GOAL_STATES = GoalDataState.mainInstance;
