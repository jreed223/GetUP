import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ShortTermGoalCard extends StatefulWidget {
  final String title;
  const ShortTermGoalCard({super.key, required this.title});

  @override
  State<ShortTermGoalCard> createState() => _ShortTermGoalCardState();
}

class _ShortTermGoalCardState extends State<ShortTermGoalCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Checkbox(
          // TODO Add functionality to checkbox
          onChanged: null,
          value: false,
        ),
        title: Text(widget.title),
        trailing: IconButton(
          // TODO Add functionality to edit button
          onPressed: null,
          icon:
              Icon(Icons.edit, size: MediaQuery.of(context).size.width * 0.05),
        ),
      ),
    );
  }
}

class LongTermGoalCard extends StatefulWidget {
  final String title;
  const LongTermGoalCard({super.key, required this.title});

  @override
  State<LongTermGoalCard> createState() => _LongTermGoalCardState();
}

class _LongTermGoalCardState extends State<LongTermGoalCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Checkbox(
          // TODO Add functionality to checkbox
          onChanged: null,
          value: false,
        ),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.title),
        ),
        subtitle: LinearPercentIndicator(
          animation: true,
          width: MediaQuery.of(context).size.width * 0.5,
          lineHeight: 5.0,
          // TODO: Percent reflects progress
          percent: 0.5,
          linearGradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
          ),
          barRadius: const Radius.circular(2),
        ),
        trailing: IconButton(
          // TODO Add functionality to edit button
          onPressed: null,
          icon:
              Icon(Icons.edit, size: MediaQuery.of(context).size.width * 0.05),
        ),
      ),
    );
  }
}
