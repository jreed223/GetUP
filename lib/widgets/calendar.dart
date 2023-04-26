import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getup_csc450/widgets/goal_display.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/helpers/theme_provider.dart';
import 'package:getup_csc450/widgets/filter.dart' as Filter;
import 'package:getup_csc450/widgets/challenge_display.dart';

class CalendarWidget extends StatefulWidget {
  int _currentPage = 0;
  CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  /// This is the goals collection for the user
  final goalsCollection = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('goals');

  /// This is the list of goals for the selected date
  final List<dynamic> _selectedGoals = [];

  PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  /// This is the formatter for the selected date
  DateFormat formatter = DateFormat.yMMMMd('en_US');

  /// This is the selected date
  DateTime _focusedDay = DateTime.now();

  /// This is the first day of the calnedar
  final DateTime _firstDay = DateTime(2023, 1, 1);

  /// This is the last day of the calendar
  final DateTime _lastDay = DateTime(2023, 12, 31);

  /// This is the boolean that determines whether the calendar is in week or month view
  bool expanded = false;

  @override
  void initState() {
    super.initState();
  }

  /// This function is called when a day is selected
  /// It sets the selected date to the focused day so that the calendar will display the goals for the selected date
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = selectedDay;
      _selectedGoals.clear();
    });
  }

  /// This function is called when the calendar is in week view and the user force presses the calendar
  void weekOrMonthView() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Filter.Filter(),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              weekOrMonthView();
            },
            selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
            calendarFormat: CalendarFormat.week,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontFamily: 'PT-Serif',
                color: themeProvider.textColor,
                fontSize: 14,
              ),
              weekendStyle: TextStyle(
                fontFamily: 'PT-Serif',
                color: themeProvider.textColor,
                fontSize: 14,
              ),
            ),
            headerStyle: HeaderStyle(
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: themeProvider.buttonColor,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: themeProvider.buttonColor,
              ),
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                letterSpacing: 1.25,
                fontFamily: 'PT-Serif',
                color: themeProvider.textColor,
                fontSize: 22,
              ),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: themeProvider.buttonColor,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(
                fontFamily: 'PT-Serif',
                color: themeProvider.textColor,
                fontSize: 14,
              ),
              defaultTextStyle: TextStyle(
                fontFamily: 'PT-Serif',
                color: themeProvider.textColor,
                fontSize: 14,
              ),
              selectedTextStyle: TextStyle(
                  fontFamily: 'PT-Serif',
                  color: themeProvider.textColor,
                  fontWeight: FontWeight.w600),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(54, 0, 0, 0),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            //child: ChallengeView(selectedDate: formatter.format(_focusedDay))
            child: PageView(
              controller: _pageController,
              children: [
                GoalView(selectedDate: formatter.format(_focusedDay)),
                ChallengeView(selectedDate: formatter.format(_focusedDay)),
              ],
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              2,
              (int index) {
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? themeProvider.buttonColor
                        : themeProvider.textColor.withOpacity(0.4),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
