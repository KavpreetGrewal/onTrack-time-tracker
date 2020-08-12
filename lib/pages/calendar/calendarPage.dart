import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ontrack_time_tracker/theme/colors.dart';
import '../settings/variables.dart';
import 'package:table_calendar/table_calendar.dart';
import '../home/homePage.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  var selectedDay = DateFormat.yMMMMEEEEd().format(DateTime.now());
  var days = DateTime.now();
  static var hours = SettingsVar.dates[SettingsVar.today];
  var controller = new TextEditingController(text: '$hours');

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    selectedDay = DateFormat.yMMMMEEEEd().format(DateTime.now());
    days = DateTime.now();
    hours = SettingsVar.dates[SettingsVar.today];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void updateSelectedDay (var day) {
    this.setState(() {
      days = day;
      selectedDay = DateFormat.yMMMMEEEEd().format(day);
      if (SettingsVar.dates[day.difference(SettingsVar.initialDate).inDays] == null) {
        hours = 0;
        controller.text = '$hours';
      } else {
        hours = SettingsVar.dates[day.difference(SettingsVar.initialDate).inDays];
        controller.text = '$hours';
      }
    });
  }

  int getDaysLeftInWeek (bool rolling) {
    int temp = 0;
    var now = new DateTime.now();
    this.setState(() {
      if (rolling) {
        temp = 6;
      } else {
        temp = 6 - now.weekday;
        if (temp == 0) {
          temp = 6;
        }
      }
    });
    return temp.toInt();
  }

  void editHours (var hour) {

    this.setState(() {
      var dateUtility = new DateUtil();
      var theDay = days.difference(SettingsVar.initialDate).inDays;
      var hoursTheDay = SettingsVar.dates[theDay] == null ? 0 : SettingsVar.dates[theDay];
      var diff = hour - hoursTheDay;
      var daysLeft = 7 - getDaysLeftInWeek(SettingsVar.rollingPeriod);

      if (SettingsVar.period == 'Week') {
        if (SettingsVar.rollingPeriod && SettingsVar.today != theDay) {
          if (SettingsVar.today - theDay < 7 && SettingsVar.today - theDay > 0) {
            SettingsVar.setwProgressOfTimePeriod(SettingsVar.wprogressOfTimePeriod + diff);
          }
        } else if (!SettingsVar.rollingPeriod && SettingsVar.today != theDay) {
          if (SettingsVar.today - theDay < daysLeft &&
              SettingsVar.today - theDay >= -(7 - daysLeft)) {
            SettingsVar.setwProgressOfTimePeriod(
                SettingsVar.wprogressOfTimePeriod + diff);
          }
        } else if (SettingsVar.today == theDay) {
          SettingsVar.currentTimePeriod = hour;
          SettingsVar.setwProgressOfTimePeriod(SettingsVar.wprogressOfTimePeriod + diff);
        }

      } else if (SettingsVar.period == 'Month') {

        if (SettingsVar.today != theDay && !SettingsVar.rollingPeriod) {
          if (days.month == DateTime.now().month) {
            SettingsVar.setmProgressOfTimePeriod(SettingsVar.mprogressOfTimePeriod + diff);
          }
        } else if (SettingsVar.today != theDay && SettingsVar.rollingPeriod) {
          if (SettingsVar.today - theDay > 0 && SettingsVar.today - theDay <
              dateUtility.daysInMonth(DateTime.now().month, DateTime.now().year)) {
            SettingsVar.setmProgressOfTimePeriod(SettingsVar.mprogressOfTimePeriod + diff);
          }
        }
        if (SettingsVar.today == theDay) {
          SettingsVar.currentTimePeriod = hour;
          SettingsVar.setmProgressOfTimePeriod(SettingsVar.mprogressOfTimePeriod + diff);
        }
      } else if (SettingsVar.period == 'Year') {

        if (SettingsVar.today != theDay && !SettingsVar.rollingPeriod) {
          if (days.year == DateTime.now().year) {
            SettingsVar.setyProgressOfTimePeriod(SettingsVar.yprogressOfTimePeriod + diff);
          }
        } else if (SettingsVar.today != theDay && SettingsVar.rollingPeriod) {
          if (SettingsVar.today - theDay > 0 && SettingsVar.today - theDay <
              dateUtility.yearLength(DateTime.now().year)) {
            SettingsVar.setyProgressOfTimePeriod(SettingsVar.yprogressOfTimePeriod + diff);
          }
        }
        if (SettingsVar.today == theDay) {
          SettingsVar.currentTimePeriod = hour;
          SettingsVar.setyProgressOfTimePeriod(SettingsVar.yprogressOfTimePeriod + diff);
        }
      }

      SettingsVar.editHours(hour, theDay);
    });
  }

  createAlertDialog(BuildContext context) {
    @override
    void initState() {
      super.initState();
      controller.text = '$hours'; // Setting the initial value for the field.
    }

    return showDialog(context: context, barrierDismissible: false, builder: (context) {
      return AlertDialog(
        title: Text("Edit Hours"),
        backgroundColor: ThemeColors.White,
        content: Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          child: TextField(
            textAlign: TextAlign.center,
            autofocus: true,
            controller: this.controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            cursorColor: ThemeColors.Red,
            decoration: InputDecoration(
              prefix: IconButton(
                icon: Icon(Icons.remove_circle_outline, color: ThemeColors.Red,),
                onPressed: () {
                  int current = int.parse(controller.text);
                  controller.text = '${--current}';
                },
              ),
              suffix: IconButton(
                icon: Icon(Icons.add_circle_outline, color: ThemeColors.Red,),
                onPressed: () {
                  int current = int.parse(controller.text);
                  controller.text = '${++current}';
                },
              ),
            ),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit',
              style: TextStyle(
                color: ThemeColors.DarkBlue,
              ),),
            color: ThemeColors.Red,
            onPressed: () {
              editHours(int.parse(controller.text));
              updateSelectedDay(days);
              Navigator.of(context).pop(controller.text.toString());
            },
          )
        ],
      );
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
      ),

      floatingActionButton: FloatingActionButton.extended (
        onPressed: () => {
          createAlertDialog(context)
        },
        tooltip: 'Edit Hours',
        icon: Icon(Icons.edit, color: ThemeColors.DarkBlue,),
        label: Text (
          'Edit Hours',
          style: TextStyle(
            color: ThemeColors.DarkBlue,
          ),
        ),
        backgroundColor: ThemeColors.Red,
      ),
    );
  }
}