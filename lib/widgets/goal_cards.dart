import 'package:flutter/material.dart';

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
              IconButton(
                onPressed: null,
                icon: Icon(Icons.check),
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
        title: Text(widget.title),
        trailing: Wrap(
          children: const <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(Icons.check),
            ),
            IconButton(onPressed: null, icon: Icon(Icons.punch_clock)),
          ],
        ),
      ),
    );
  }
}
