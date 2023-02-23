import 'package:getup_csc450/models/goals.dart';

/// Metrics class to display data and goal progress by group and/or time
class Metrics extends Goal {
  Duration timePeriod = Duration(
      days: 1); //Specifies the time period the data is from(defaults 1 day)
  String groupSelection =
      "All"; //Specifies data of a specific goal category(defaults all categories)
  double
      goalPrcnt; //calculates progress for each goal (actualTime/ExpectedTime)

  ///Initializes Metrics class
  Metrics(
      {required this.groupSelection,
      required this.timePeriod,
      required this.goalPrcnt,
      required super.title});

  ///Sets category of goals
  set group(String goalCat) {
    groupSelection = goalCat;
  }

  ///sets how many days of data to be displayed
  set time(int days) {
    timePeriod = Duration(days: days);
  }

  //returns percentage of progress completed for each goal
  double get prcntProgress {
    return goalPrcnt;
  }

  //method for calculating progress percentage
  double prcnt(actTime, expTime) {
    goalPrcnt = actTime / expTime;
    return goalPrcnt;
  }

  //Example Goals
  final goal1 = Metrics(
      timePeriod: Duration(days: 7),
      groupSelection: "Fitness",
      goalPrcnt: 80.0,
      title: 'Workout an hour each day');

  final goal2 = Metrics(
      timePeriod: Duration(days: 1),
      groupSelection: "Education",
      goalPrcnt: 100.0,
      title: 'Read a chapter each day');
}
