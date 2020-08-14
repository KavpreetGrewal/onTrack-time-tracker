import 'dart:collection';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsVar {
  static var andriod = !Platform.isIOS;
  static var initialDate = DateTime.parse('20200101');
  static var today = DateTime.now().difference(initialDate).inDays;
  static var lastDate = DateTime.now().difference(initialDate).inDays;
  static HashMap<int, int> dates = new HashMap();

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
  static String email = '';
  static String password = '';
  static FirebaseUser user;
  static GoogleSignInAccount googleAccount;

  static void setUser(FirebaseUser user) {
    SettingsVar.user = user;
  }

  static void setGoogleAccount(GoogleSignInAccount user) {
    SettingsVar.googleAccount = user;
  }

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
    // writeDates();
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
    // writeDates();
  }
  static void setEmail(String email) {
    SettingsVar.email = email;
  }
  static void setPassword(String password) {
    SettingsVar.password = password;
  }



  static void changeProgress() {
    if (SettingsVar.rollingPeriod) {
      if (SettingsVar.period == 'Week') {
        int temp = 0;
        for (int i = 0; i < 7; i++) {
          temp += SettingsVar.dates[SettingsVar.today - i] == null ? 0:SettingsVar.dates[SettingsVar.today - i];
        }
        SettingsVar.setwProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Month') {
        int temp = 0;
        for (int i = 0; i < DateUtil().daysInMonth(
            DateTime.now().month, DateTime.now().year); i++) {
          temp += SettingsVar.dates[SettingsVar.today - i] == null ? 0:SettingsVar.dates[SettingsVar.today - i];
        }
        SettingsVar.setmProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Year') {
        int temp = 0;
        for (int i = 0; i < DateUtil().yearLength(DateTime.now().year); i++) {
          temp += SettingsVar.dates[SettingsVar.today - i] == null ? 0:SettingsVar.dates[SettingsVar.today - i];
        }
        SettingsVar.setyProgressOfTimePeriod(temp);
      }
    } else {
      if (SettingsVar.period == 'Week') {
        int temp = 0;
        var dayNum = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;

        for (int i = 0; i < 7; i++) {
          var diff = i - dayNum;
          temp += SettingsVar.dates[SettingsVar.today + diff] == null ? 0:SettingsVar.dates[SettingsVar.today + diff];
        }
        SettingsVar.setwProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Month') {
        int temp = 0;
        var start = DateTime.utc(DateTime.now().year, DateTime.now().month, 01).
        difference(DateTime.parse('20200101')).inDays + 1;
        var end = DateTime.utc(DateTime.now().year, DateTime.now().month  ,
            DateUtil().daysInMonth(DateTime.now().month , DateTime.now().year ))
            .difference(DateTime.parse('20200101')).inDays + 1;

        for (int i = start; i <= end; i++) {
          temp += SettingsVar.dates[i] == null ? 0:SettingsVar.dates[i];
        }
        SettingsVar.setmProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Year') {
        int temp = 0;
        var start = DateTime.utc(DateTime.now().year, 01 , 01).difference(DateTime.parse('20200101')).inDays;
        var end = DateTime.utc(DateTime.now().year, 12 , 31).difference(DateTime.parse('20200101')).inDays + 1;
        for (int i = start; i <= end; i++) {
          temp += SettingsVar.dates[i] == null ? 0:SettingsVar.dates[i];
        }
        SettingsVar.setyProgressOfTimePeriod(temp);
      }

    }
  }


//  static Future<String> get _localPath async {
//    final directory = await getApplicationDocumentsDirectory();
//
//    return directory.path;
//  }
//  static Future<File> get _localFile async {
//    final path = await _localPath;
//    return File('$path/counter.txt');
//  }
//  static Future<File> writeDates() async {
//    final file = await _localFile;
//
//    // Write the file.
//    file.writeAsStringSync('');
//
//    return file.writeAsString('${json.encode(SettingsVar.dates)}');
//  }
//  static Future<Map> readDates() async {
//    try {
//      final file = await _localFile;
//
//      // Read the file.
//      String contents = await file.readAsString();
//      dates = json.decode(contents);
//      return null;
//    } catch (e) {
//      // If encountering an error, return 0.
//      dates = new HashMap();
//      return null;
//    }
//  }

}