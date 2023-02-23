///Class holds data needed to create visualizations for goal Data
class metricsData {
  int goalsCompleted;
  int totalGoals;
  double actTime; //actual time spent in hours
  double expTime; //expected time spent in hours
  String date;

  ///initializes data
  metricsData(
      {required this.goalsCompleted,
      required this.totalGoals,
      required this.actTime,
      required this.expTime,
      required this.date});

  ///Creates a list of objects containing data for each day of the week
  static List<metricsData> dailyData = [
    metricsData(
        goalsCompleted: 1,
        totalGoals: 4,
        actTime: 1.0,
        expTime: 3.0,
        date: 'Mon'),
    metricsData(
        goalsCompleted: 3,
        totalGoals: 5,
        actTime: 2.0,
        expTime: 2.0,
        date: "Tues"),
    metricsData(
        goalsCompleted: 2,
        totalGoals: 5,
        actTime: 1.0,
        expTime: 3.0,
        date: "Wed"),
    metricsData(
        goalsCompleted: 6,
        totalGoals: 6,
        actTime: 4.0,
        expTime: 4.0,
        date: "Thurs"),
    metricsData(
        goalsCompleted: 4,
        totalGoals: 5,
        actTime: 3.0,
        expTime: 4.0,
        date: "Fri"),
    metricsData(
        goalsCompleted: 8,
        totalGoals: 8,
        actTime: 6.0,
        expTime: 6.0,
        date: "Sat"),
    metricsData(
        goalsCompleted: 5,
        totalGoals: 7,
        actTime: 3.0,
        expTime: 4.0,
        date: "Sun"),
  ];
}

///Class used to calculate data received in the MetricsData class
class metricsController {
  double timePrcntg;
  double completionPrcntg;

  metricsController({required this.timePrcntg, required this.completionPrcntg});

  double prcntTime(actTime, expTime) {
    // method measures progress by comparing time spent to the expected time spent
    timePrcntg = actTime / expTime;
    return timePrcntg;
  }

  double prcntComplete(goalsCompleted, totalGoals) {
    // method measures progress by comparing goals completed to the amount of goals created
    completionPrcntg = goalsCompleted / totalGoals;
    return completionPrcntg;
  }

  double get timeProgress =>
      timePrcntg; //getter that retrieves percentage of progress based on time

  double get completedProgress =>
      completionPrcntg; //getter that retrieves percentage of goals fully completed
}
