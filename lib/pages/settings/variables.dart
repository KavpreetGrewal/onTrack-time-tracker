import 'dart:collection';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';

class SettingsVar {
  static var initialDate = DateTime.parse('20200101');
  static var today = DateTime.now().difference(initialDate).inDays;
  static var lastDate = DateTime.now().difference(initialDate).inDays;
  static var dates = new HashMap();

  static var timeFrame = 'Hour';
  static var timeFrameAdj = 'Hourly';
  static var period = 'Week';
  static var periodAdj = 'Weekly';
  static var totalTimePeriod = 70;
  static var wprogressOfTimePeriod = 0;
  static var mprogressOfTimePeriod = 0;
  static var yprogressOfTimePeriod = 0;
  static var currentTimePeriod = 0;
  static var dailyMax = 12;
  static var rollingPeriod = false;

  static void setTimeFrame(String time) {
    SettingsVar.timeFrame = time;
    SettingsVar.timeFrameAdj = time + 'ly';
  }
  static void setPeriod(String time) {
    SettingsVar.period = time;
    SettingsVar.periodAdj = time + 'ly';
  }
  static void setTotalTimePeriod(var time) {
    SettingsVar.totalTimePeriod = time;
  }
  static void setwProgressOfTimePeriod(var time) {
    SettingsVar.wprogressOfTimePeriod = time;
  }
  static void setmProgressOfTimePeriod(var time) {
    SettingsVar.mprogressOfTimePeriod = time;
  }
  static void setyProgressOfTimePeriod(var time) {
    SettingsVar.yprogressOfTimePeriod = time;
  }
  static void setCurrentTimePeriod(var time) {
    SettingsVar.wprogressOfTimePeriod += time - SettingsVar.currentTimePeriod;
    SettingsVar.mprogressOfTimePeriod += time - SettingsVar.currentTimePeriod;
    SettingsVar.yprogressOfTimePeriod += time - SettingsVar.currentTimePeriod;
    SettingsVar.dates.update(SettingsVar.today,
            (value) => time, ifAbsent: () => time);
    SettingsVar.currentTimePeriod = dates[today];
  }
  static void setDailyMax(var time) {
    SettingsVar.dailyMax = time;
  }
  static void setRollingPeriod(bool time) {
    SettingsVar.rollingPeriod = time;
  }
  static void editHours(var hours, var day) {
    SettingsVar.dates.update(day,
            (value) => hours, ifAbsent: () => hours);
  }



  static void changeProgress() {
    if (SettingsVar.rollingPeriod) {
      if (SettingsVar.period == 'Week') {
        var temp = 0;
        for (int i = 0; i < 7; i++) {
          temp += SettingsVar.dates[SettingsVar.today - i];
          temp += 1;
        }
        SettingsVar.setwProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Month') {
        var temp = 0;
        for (int i = 0; i < DateUtil().daysInMonth(
            DateTime.now().month, DateTime.now().year); i++) {
          temp += SettingsVar.dates[SettingsVar.today - i];
        }
        SettingsVar.setmProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Year') {
        var temp = 0;
        for (int i = 0; i < DateUtil().yearLength(DateTime.now().year); i++) {
          temp += SettingsVar.dates[SettingsVar.today - i];
        }
        SettingsVar.setyProgressOfTimePeriod(temp);
      }
    } else {
      if (SettingsVar.period == 'Week') {
        var temp = 0;
        var dayNum = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;

        for (int i = 0; i < 7; i++) {
          var diff = i - dayNum;
          temp += SettingsVar.dates[SettingsVar.today + diff];
        }
        SettingsVar.setwProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Month') {
        var temp = 0;
        var start = DateTime.utc(DateTime.now().year, DateTime.now().month, 01).
        difference(DateTime.parse('20200101')).inDays;
        var end = DateTime.utc(DateTime.now().year, DateTime.now().month  ,
            DateUtil().daysInMonth(DateTime.now().month , DateTime.now().year ))
            .difference(DateTime.parse('20200101')).inDays;

        for (int i = start; i <= end; i++) {
          temp += SettingsVar.dates[i];
        }
        SettingsVar.setmProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Year') {
        var temp = 0;
        var start = DateTime.utc(DateTime.now().year, 01 , 01).difference(DateTime.parse('20200101')).inDays;
        var end = DateTime.utc(DateTime.now().year, 12 , 31).difference(DateTime.parse('20200101')).inDays;
        for (int i = start; i <= end; i++) {
          temp += SettingsVar.dates[i];
        }
        SettingsVar.setyProgressOfTimePeriod(temp);
      }

    }
  }
}