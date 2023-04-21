import "goals.dart";

///Class holds data needed to create visualizations for goal Data
class MetricsData {
  //short term data
  double numSTcompleted; // total completed short term goals
  double numShortGoals; //total short term goals
  double completionPrcnt; //percent of completed short term goals
  //long term data
  double totalLTprogress; //total long term goal progress
  double totalDuration; //total long term goal duration
  double numLongGoals;
  double durationPrcnt; //percent of duration completed for ong term goals
  //overall data
  double numOverallCmplt;
  double totalGoals;
  double overallCmpltPrcnt;
  double overallProgressPrcnt; // percent of progress of all goals

  ///initializes data
  MetricsData(
      {required this.numSTcompleted,
      required this.numShortGoals,
      required this.completionPrcnt,
      required this.totalLTprogress,
      required this.totalDuration,
      required this.numLongGoals,
      required this.durationPrcnt,
      required this.numOverallCmplt,
      required this.totalGoals,
      required this.overallCmpltPrcnt,
      required this.overallProgressPrcnt});
}

///Class used to calculate and handle data received for the MetricsData class
class MetricsController {
  final List? goalList;
  final Goal? shortGoal;
  final LongTermGoal? longGoal;

  MetricsController({this.goalList, this.shortGoal, this.longGoal});

  ///SHORT TERM GOAL DATA HANDLING
  //Method calculates the percent of short term goals completed
  List<double> shortPrcntCmplt() {
    double shortCmpltCnt = 0; //completed goal counter
    double numShortGoals = 0; //short term goal counter

    // for loop iterates through the goalList
    for (var i = 0; i < goalList!.length; i++) {
      var currentGoal = goalList![i];
      //if statement targets each short term goal
      if (currentGoal is Goal) {
        numShortGoals = numShortGoals + 1;
        //if statement targets each completed short term goal
        if (currentGoal.isCompleted == true) {
          shortCmpltCnt = shortCmpltCnt + 1;
        }
      }
    }
    //calculates percnet of short term goals complete
    double completionPrcnt = (shortCmpltCnt / numShortGoals) * 100;
    return [
      shortCmpltCnt,
      numShortGoals,
      completionPrcnt
    ]; //returns list of data
  }

  ///LONG TERM GOAL DATA HANDLING
  //Method calculates the percentage of duration completed for all Longterm goals
  List<double> prcntDuration() {
    double totalProgress = 0; //progress counter
    double totalDuration = 0; //duration counter
    double numLongGoals = 0;

    // for loop iterates through the goalList
    for (var i = 0; i < goalList!.length; i++) {
      var currentGoal = goalList![i];
      //if statement targets each long term goal
      if (currentGoal is LongTermGoal) {
        numLongGoals = numLongGoals + 1;
        //adds the getter stored value to the progress counter
        totalProgress = totalProgress + currentGoal.goalProgress;
        //adds the getter stored value to the duration counter
        totalDuration =
            totalDuration + double.parse(currentGoal.goalDuration as String);
      }
    }
    double durationPrcnt =
        (totalProgress / totalDuration) * 100; //calulcates percentage
    return [
      totalProgress,
      totalDuration,
      numLongGoals,
      durationPrcnt
    ]; //returns list of data
  }

  ///OVERALL DATA HANDLING
  //Method calculates the percent of all goals completed
  List<double> prcntOverallCmplt() {
    // for loop iterates through the goalList
    double totalGoals = 0;
    double overallCmpltCnt = 0;
    for (var i = 0; i < goalList!.length; i++) {
      var currentGoal = goalList![i];
      totalGoals = totalGoals + 1;
      //if statement targets each long term goal
      if (currentGoal is LongTermGoal) {
        //if statement targets each completed long term goal
        if (currentGoal.isCompleted == true ||
            double.parse(currentGoal.goalDuration as String) ==
                currentGoal.goalProgress) {
          overallCmpltCnt = overallCmpltCnt + 1;
        }
      } else if (currentGoal is Goal) {
        //else catches short term goals
        if (currentGoal.isCompleted == true) {
          overallCmpltCnt = overallCmpltCnt + 1;
        }
      }
    }
    double overallCompltPrcnt = (overallCmpltCnt / totalGoals) * 100;
    return [overallCmpltCnt, totalGoals, overallCompltPrcnt];
  }

//Method calculates percentage of all goals completed using the prcntComplete and prcntDuration methods
  double prcntOverallProgress() {
    //averages the the values of the two function calls
    double overallPrcnt =
        (shortPrcntCmplt().elementAt(2) + prcntDuration().elementAt(3)) / 2;
    return overallPrcnt;
  }
}

// final List<Goal> _sampleGoals = [
//   LongTermGoal(title: 'Learn Flutter', duration: '20'),
//   Goal(title: 'Go to grocery store'),
//   LongTermGoal(title: 'Read', duration: '5'),
//   Goal(title: 'Go to the gym'),
//   LongTermGoal(title: 'Learn Dart', duration: '10'),
//   Goal(title: 'Go to the dentist'),
//   LongTermGoal(title: 'Learn Python', duration: '15'),
// ];

class MetricsCalc {
  List<Goal> sampleList;
  late MetricsData dataVals;
  MetricsCalc({required this.sampleList});

  MetricsData calcData() {
    final sampleController = MetricsController(goalList: sampleList);
    final sampleData = MetricsData(

        //Short term data
        numSTcompleted: sampleController
            .shortPrcntCmplt()
            .elementAt(0), //return idx[0] for prcntComplete func
        numShortGoals: sampleController
            .shortPrcntCmplt()
            .elementAt(1), //return idx[1] prcntComplete  func
        completionPrcnt: sampleController
            .shortPrcntCmplt()
            .elementAt(2), //return idx[2] for prcntComplete func
        //Long term data
        totalLTprogress: sampleController
            .prcntDuration()
            .elementAt(0), //return idx[0] for  prcntDuration func
        totalDuration: sampleController
            .prcntDuration()
            .elementAt(1), //return idx[1] for prcntDuration func
        numLongGoals: sampleController
            .prcntDuration()
            .elementAt(2), //return idx[2] for prcntDuration func
        durationPrcnt: sampleController
            .prcntDuration()
            .elementAt(3), //return idx[3] for prcntDuration func
        //Overall Data
        numOverallCmplt: sampleController
            .prcntOverallCmplt()
            .elementAt(0), //return idx[0] for prcntOverallCmplt func
        totalGoals: sampleController
            .prcntOverallCmplt()
            .elementAt(1), //return idx[1] for prcntOverallCmplt func
        overallCmpltPrcnt: sampleController
            .prcntOverallCmplt()
            .elementAt(2), //return idx[2] for prcntOverallCmplt func
        overallProgressPrcnt: sampleController
            .prcntOverallProgress()); //return prcntOverallProgress func value

    return sampleData;
  }

  void call(sampleList) {
    calcData();
    dataVals = calcData();
  }
}
