import 'package:flutter/material.dart';
import 'package:getup_csc450/models/metricsController.dart';

import 'goals.dart';

class DataQueue {
  final List<Goal> goalList;
  List<List<Goal>> queueList = [[], [], [], [], [], [], []];
  List<MetricsData> metricsQueue = [];

  DataQueue({required this.goalList});

  List<MetricsData> calcWeeklyMetrics(goalList) {
    DataQueue dailyMetrics = DataQueue(goalList: goalList);
    dailyMetrics.addMetrics();
    return metricsQueue;
  }

  //Method for creting list of active goals for the current date
  List<Goal> dailyGoals() {
    List<Goal> todaysGoals = [];
    var currentDay = DateTime.now().day;
    var currentMonth = DateTime.now().month;

    //Iterate through list starting at the end
    goalList.sort((a, b) {
      return a.dateCreated
          .compareTo(b.dateCreated); //sorts list using dates ascending order
    });
    goalList.sort();
    for (var i = goalList.length; i > 0; i--) {
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
  void addMetrics() {
    List<Goal> todaysGoals = dailyGoals();
    MetricsData todaysMetrics = calcData(todaysGoals);
    todaysMetrics.dataCollectionDate = DateTime.now();
    metricsQueue.add(todaysMetrics); //Function call adds metrics for today
    mSize();
  }

  void removeMetrics(idx) {
    metricsQueue.removeAt(idx);
  }

  void mSize() {
    if ((metricsQueue.length > 7) &
        (metricsQueue[6].dataCollectionDate.day != DateTime.now().day)) {
      removeMetrics(0);
    } else if ((metricsQueue.length > 7) &
        (metricsQueue[6].dataCollectionDate.day == DateTime.now().day)) {
      removeGoals(6);
    }
  }

  /// methods for controlling Goal Queue
  void addGoals() {
    queueList.add(dailyGoals()); //Function call add todays goal's to list
    gSize();
  }

  void removeGoals(idx) {
    queueList.removeAt(idx);
  }

  void gSize() {
    if ((queueList.length > 7) &
        (queueList[6][0].dateCreated.day != DateTime.now().day)) {
      removeGoals(0);
    } else if ((queueList.length > 7) &
        (queueList[6][0].dateCreated.day == DateTime.now().day)) {
      removeGoals(6);
    }
  }
}
