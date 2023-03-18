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
          title: Text(widget.title),
          trailing: Wrap(
            children: const <Widget>[
              IconButton(
                onPressed: null,
                icon: Icon(Icons.edit),
              ),
            ],
          )),
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
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.title),
        ),
        subtitle: LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * 0.6,
          lineHeight: 5.0,
          percent: 0.5,
          progressColor: Colors.blue,
        ),
        trailing: Wrap(
          children: const <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
