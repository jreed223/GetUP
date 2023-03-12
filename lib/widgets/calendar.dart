import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/models/firebaseController.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreController _firestoreController = FirestoreController();
  late Map<DateTime, List<dynamic>> _events;
  List _selectedGoals = [];

  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime(2023, 1, 1);
  DateTime _lastDay = DateTime(2023, 12, 31);

  bool expanded = false;

  @override
  void initState() {
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = selectedDay;
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
                  color: Colors.red,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.red,
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
                  color: Colors.red,
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
            child: StreamBuilder(
              stream: _firestoreController.getGoalsByDate(
                _auth.currentUser!.uid,
                _focusedDay,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  // If there is no data in the snapshot, return a loading indicator
                  return const CircularProgressIndicator();
                }

                // Assign the snapshot data to a variable
                List<dynamic> selectedGoals = snapshot.data as List<dynamic>;

                if (selectedGoals.isEmpty) {
                  // If there are no goals for the selected date, display a message to the user
                  return const Center(
                    child: Text('No goals for selected date.'),
                  );
                }

                // If there are goals for the selected date, display them in an AnimatedList
                return AnimatedList(
                  initialItemCount: selectedGoals.length,
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: Card(
                        child: ListTile(
                          title: Text(selectedGoals[index]['title']),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
