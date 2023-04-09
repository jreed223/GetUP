import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:getup_csc450/models/metricsController.dart';
import 'package:intl/intl.dart';

import 'goals.dart';

class DataQueue {
  final List goalList;
  List<List> goalQueue = [[], [], [], [], [], [], []];
  List<MetricsData> metricsQueue = [];

  MetricsData m0 = MetricsData(
      numSTcompleted: 0,
      numShortGoals: 0,
      completionPrcnt: 0,
      totalLTprogress: 0,
      totalDuration: 0,
      numLongGoals: 0,
      durationPrcnt: 0,
      numOverallCmplt: 0,
      totalGoals: 0,
      overallCmpltPrcnt: 0,
      overallProgressPrcnt: 0);

  var todaysDate = DateFormat('EEEE, d MMM, yyyy').format(DateTime.now());
  var dayOfWeek = DateFormat('EEEE').format(DateTime.now());

  DataQueue({required this.goalList});

  //Method for creting list of active goals for the current date
  List dailyGoals() {
    List todaysGoals = [];
    var currentDay = DateTime.now().day;
    var currentMonth = DateTime.now().month;

    //Iterate through list starting at the end
    goalList.sort((a, b) {
      return a.dateCreated
          .compareTo(b.dateCreated); //sorts list using dates ascending order
    });
    goalList.sort();
    for (var i = goalList.length - 1; i > 0; i--) {
      var currentGoal = goalList[i];
      //if statement targets each goal returns list curren
      if (currentGoal.isLongTerm == false) {
        //add short term goals to list
        if ((currentGoal.dateCreated.day ==
                currentDay) & //checks for goals matching current date befor adding
            (currentGoal.dateCreated.month == currentMonth)) {
          todaysGoals.add(currentGoal);
        }
      } else if (currentGoal.isLongTerm == true) {
        //adds long term goal to list
        if (((currentGoal.isCompleted ==
                false) || //Adds incomplete long term goals to list
            (currentGoal.dateCompleted?.day == DateTime.now().day))) {
          //Checks if goal was completed on current day to add progress
          todaysGoals.add(currentGoal);
        }
      }
    }
    return todaysGoals;
  }

  ///Methods for controlling Metrics Queue

  void zeroMetrics() {
    while (metricsQueue.length < 7) {
      metricsQueue.insert(0, m0);
    }
  }

  void addMetrics() {
    // prints Tuesday
    List todaysGoals = dailyGoals();
    MetricsData todaysMetrics = calcData(todaysGoals);
    todaysMetrics.dataCollectionDate = todaysDate;
    todaysMetrics.dayOfWeek = dayOfWeek; // prints Tuesday

    zeroMetrics(); //initilizes Metrics Data with values of zero
    metricsQueue.add(todaysMetrics); //Function call adds metrics for today
    mSize(); //Manage the size of metrics Queuelist
  }

  void mSize() {
    if ((metricsQueue.length > 7) &
        (metricsQueue[6].dataCollectionDate != todaysDate)) {
      metricsQueue.removeAt(6);
    } else if ((metricsQueue.length > 7) &
        (metricsQueue[6].dataCollectionDate == todaysDate)) {
      metricsQueue.removeAt(0);
    }
  }

  /// methods for controlling Goal Queue
  void addGoals() {
    goalQueue.add(dailyGoals()); //Function call add todays goal's to list
    gSize();
  }

  void gSize() {
    if ((goalQueue.length > 7) &
        (goalQueue[6][0].dateCreated.day != DateTime.now().day)) {
      goalQueue.removeAt(0);
    } else if ((goalQueue.length > 7) &
        (goalQueue[6][0].dateCreated.day == DateTime.now().day)) {
      goalQueue.removeAt(6);
    }
  }
}

List<MetricsData> calcWeeklyMetrics(goalList) {
  DataQueue dailyMetrics = DataQueue(goalList: goalList);
  dailyMetrics.addMetrics();
  return dailyMetrics.metricsQueue;
}
