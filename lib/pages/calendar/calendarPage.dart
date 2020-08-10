import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ontrack_time_tracker/theme/colors.dart';
import '../settings/variables.dart';
import 'package:table_calendar/table_calendar.dart';
import '../settings/variables.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  var selectedDay = DateFormat.yMMMMEEEEd().format(DateTime.now());
  var hours = SettingsVar.dates[SettingsVar.today];

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void updateSelectedDay (var day) {
    this.setState(() {
      selectedDay = DateFormat.yMMMMEEEEd().format(day);
      if (SettingsVar.dates[day.difference(SettingsVar.initialDate).inDays] == null) {
        hours = 0;
      } else {
        hours = SettingsVar.dates[day.difference(SettingsVar.initialDate).inDays];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
              selectedColor: ThemeColors.Red,
              todayColor: ThemeColors.Blue,
              markersColor: ThemeColors.DarkBlue,
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
              formatButtonDecoration: BoxDecoration(
                color: ThemeColors.Red,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onDaySelected: (day, days) {
                updateSelectedDay(day);
            },
          ),

          Container (
            padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w700,
                          color: ThemeColors.DarkBlue,
                          fontFamily: 'Poppins', height: 1.2,
                        ),
                        children: <TextSpan> [
                          TextSpan(text: 'You logged  '),
                          TextSpan(text:
                          '$hours',

                            style: TextStyle(fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                                color: ThemeColors.Red),),
                          TextSpan(text: '  hours on '),
                          TextSpan(text:
                          '$selectedDay',
                            style: TextStyle(fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                                color: ThemeColors.Red),),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}