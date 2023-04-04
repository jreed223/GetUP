import 'package:getup_csc450/models/goals.dart';
import 'metricsController.dart';
import 'goal_organizer.dart';

final List<Goal> _sampleGoalsM = [
  LongTermGoal(title: 'Learn Flutter', duration: 20),
  Goal(title: 'ijbib'),
  LongTermGoal(title: 'Read', duration: 5),
  Goal(title: 'Go to the gym'),
  LongTermGoal(title: 'Learn Dart', duration: 10),
  Goal(title: 'Go to the dentist'),
  LongTermGoal(title: 'Learn Python', duration: 15),
];

/// this class represents one bar in a bar graph
class DataPoints {
  final String day; //weekday
  final double val; //overall percentage

  DataPoints({
    required this.day,
    required this.val,
  });
}

List<DataPoints> setLineData(List<Goal> sampleList) {
  DataPoints lineData1 = DataPoints(
      day: sampleList[0].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints lineData2 = DataPoints(
      day: sampleList[1].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints lineData3 = DataPoints(
      day: sampleList[2].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints lineData4 = DataPoints(
      day: sampleList[3].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints lineData5 = DataPoints(
      day: sampleList[4].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints lineData6 = DataPoints(
      day: sampleList[5].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints lineData7 = DataPoints(
      day: sampleList[6].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  return [
    lineData1,
    lineData2,
    lineData3,
    lineData4,
    lineData5,
    lineData6,
    lineData7
  ];
}

List<DataPoints> setBarData(List<Goal> sampleList) {
  DataPoints barData1 = DataPoints(
      day: sampleList[0].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints barData2 = DataPoints(
      day: sampleList[1].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints barData3 = DataPoints(
      day: sampleList[2].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints barData4 = DataPoints(
      day: sampleList[3].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints barData5 = DataPoints(
      day: _sampleGoalsM[4].goalCreationDate,
      val: calcData(_sampleGoalsM).completionPrcnt);
  DataPoints barData6 = DataPoints(
      day: sampleList[5].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints barData7 = DataPoints(
      day: sampleList[6].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  return [barData1, barData2, barData3, barData4, barData5, barData6, barData7];
}

/// this class represents a single slice in a pie chart

List<DataPoints> setPieData(List<Goal> sampleList) {
  DataPoints pieData1 = DataPoints(
      day: sampleList[0].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints pieData2 = DataPoints(
      day: sampleList[1].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints pieData3 = DataPoints(
      day: sampleList[2].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints pieData4 = DataPoints(
      day: sampleList[3].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints pieData5 = DataPoints(
      day: _sampleGoalsM[4].goalCreationDate,
      val: calcData(_sampleGoalsM).completionPrcnt);
  DataPoints pieData6 = DataPoints(
      day: sampleList[5].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  DataPoints pieData7 = DataPoints(
      day: sampleList[6].goalCreationDate,
      val: calcData(sampleList).completionPrcnt);
  return [pieData1, pieData2, pieData3, pieData4, pieData5, pieData6, pieData7];
}
