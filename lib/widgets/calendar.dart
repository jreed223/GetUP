import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/widgets/goal_display.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final goalsCollection = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('goals');
  List<dynamic> _selectedGoals = [];
  DateFormat formatter = DateFormat.yMMMMd('en_US');

  DateTime _focusedDay = DateTime.now();
  // String _formattedFocusedDay = DateFormat.yMMMMd('en_US').format(_focusedDay);
  final DateTime _firstDay = DateTime(2023, 1, 1);
  final DateTime _lastDay = DateTime(2023, 12, 31);

  bool expanded = false;

  @override
  void initState() {
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = selectedDay;
      _selectedGoals.clear();
    });
  }

  void weekOrMonthView() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onForcePressPeak: (details) {
              weekOrMonthView();
            },
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: _firstDay,
              lastDay: _lastDay,
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                weekOrMonthView();
              },
              selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
              calendarFormat:
                  expanded ? CalendarFormat.month : CalendarFormat.week,
              headerStyle: const HeaderStyle(
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Color.fromARGB(255, 255, 119, 0),
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Color.fromARGB(255, 255, 119, 0),
                ),
                formatButtonVisible: true,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 119, 0),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(54, 0, 0, 0),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
              child: GoalView(selectedDate: formatter.format(_focusedDay))),
        ],
      ),
    );
  }
}
