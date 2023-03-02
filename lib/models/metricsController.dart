import "goals.dart";

///Class holds data needed to create visualizations for goal Data
class MetricsData {
  double completionPrcnt;
  double durationPrcnt;
  double overallPrcnt;
  double totalDuration;

  ///initializes data
  MetricsData(
      {required this.completionPrcnt,
      required this.durationPrcnt,
      required this.overallPrcnt,
      required this.totalDuration});

  ///Creates a list of objects containing data for each day of the week
  static List<MetricsData> dailyData = [
    MetricsData(
      completionPrcnt: 85.00,
      durationPrcnt: 44.00,
      overallPrcnt: 55.00,
      totalDuration: 60.00,
    )
  ];
}

///Class used to calculate and handle data received for the MetricsData class
class MetricsController {}

double prcntTime(progress, duration) {
  // method measures progress by comparing time spent to the expected time spent
  double durationPrcnt = progress / duration;
  return durationPrcnt;
}

double prcntComplete(goalsCompleted, totalGoals) {
  // method measures progress by comparing goals completed to the amount of goals created
  double completionPrcnt = goalsCompleted / totalGoals;
  return completionPrcnt;
}

double prcntOverall(completionPrcnt, durationPrcnt) {
  double overallPrcnt = (completionPrcnt + durationPrcnt) / 2;
  return overallPrcnt;
}

MetricsController sample = new MetricsController();
void main() {
  final List<Goal> _sampleGoals = [
    LongTermGoal(title: 'Learn Flutter', duration: 20),
    Goal(title: 'Go to grocery store'),
    LongTermGoal(title: 'Read', duration: 5),
    Goal(title: 'Go to the gym'),
    LongTermGoal(title: 'Learn Dart', duration: 10),
    Goal(title: 'Go to the dentist'),
    LongTermGoal(title: 'Learn Python', duration: 15),
  ];
  for (var i = 0; i < _sampleGoals.length; i++) {
    // TO DO
    var currentGoal = _sampleGoals[i];
    print(currentGoal);
  }
}
