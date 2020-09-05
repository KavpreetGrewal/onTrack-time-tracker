import 'dart:convert';
import 'package:date_util/date_util.dart';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../sharedPreferences/variablesStorage.dart';

class SettingsVar {
  SettingsVar() {
    StoredVar.getLoggedIn();
    StoredVar.getTimeFrame();
    StoredVar.getPeriod();
    StoredVar.getTotalTimePeriod();
    StoredVar.getwprogressOfTimePeriod();
    StoredVar.getmprogressOfTimePeriod();
    StoredVar.getyprogressOfTimePeriod();
    StoredVar.getCurrentTimePeriod();
    StoredVar.getDailyMax();
    StoredVar.getRollingPeriod();
    StoredVar.getEmail();
    StoredVar.getPassword();
    StoredVar.getDates();
  }

  static var andriod = !Platform.isIOS;
  static dynamic loggedIn = false;
  static var initialDate = DateTime.parse('20200101');
  static var today = DateTime.now().difference(initialDate).inDays;
  static var lastDate = DateTime.now().difference(initialDate).inDays;
  static Map<String, dynamic> dates = new Map<String, dynamic>();

  static dynamic timeFrame = 'Hour';
  static var timeFrameAdj = 'Hourly';
  static dynamic period = 'Week';
  static var periodAdj = 'Weekly';
  static dynamic totalTimePeriod = 70;
  static dynamic wprogressOfTimePeriod = 0;
  static dynamic mprogressOfTimePeriod = 0;
  static dynamic yprogressOfTimePeriod = 0;
  static dynamic currentTimePeriod = 0;
  static dynamic dailyMax = 12;
  static dynamic rollingPeriod = true;
  static dynamic email = '';
  static dynamic password = '';
  static FirebaseUser user;
  static GoogleSignInAccount googleAccount;


  static void setLoggedIn(bool res) {
    SettingsVar.loggedIn = res;
    StoredVar.setLoggedIn(res);
  }

  static void setUser(FirebaseUser user) {
    SettingsVar.user = user;
  }

  static void setGoogleAccount(GoogleSignInAccount user) {
    SettingsVar.googleAccount = user;
  }

  static void setTimeFrame(String time) {
    SettingsVar.timeFrame = time;
    SettingsVar.timeFrameAdj = time + 'ly';
    StoredVar.setTimeFrame(time);
  }
  static void setPeriod(String time) {
    SettingsVar.period = time;
    SettingsVar.periodAdj = time + 'ly';
    StoredVar.setPeriod(time);
  }
  static void setTotalTimePeriod(var time) {
    SettingsVar.totalTimePeriod = time;
    StoredVar.setTotalTimePeriod(time);
  }
  static void setwProgressOfTimePeriod(var time) {
    SettingsVar.wprogressOfTimePeriod = time;
    StoredVar.setwprogressOfTimePeriod(time);
  }
  static void setmProgressOfTimePeriod(var time) {
    SettingsVar.mprogressOfTimePeriod = time;
    StoredVar.setmprogressOfTimePeriod(time);
  }
  static void setyProgressOfTimePeriod(var time) {
    SettingsVar.yprogressOfTimePeriod = time;
    StoredVar.setyprogressOfTimePeriod(time);
  }
  static void setCurrentTimePeriod(var time) {
    var diff = time - currentTimePeriod;
    SettingsVar.wprogressOfTimePeriod += diff;
    StoredVar.setwprogressOfTimePeriod(SettingsVar.wprogressOfTimePeriod + diff);
    SettingsVar.mprogressOfTimePeriod += time - SettingsVar.currentTimePeriod;
    StoredVar.setmprogressOfTimePeriod(SettingsVar.mprogressOfTimePeriod + diff);
    SettingsVar.yprogressOfTimePeriod += time - SettingsVar.currentTimePeriod;
    StoredVar.setyprogressOfTimePeriod(SettingsVar.yprogressOfTimePeriod + diff);

    SettingsVar.dates.update('${SettingsVar.today}',
            (value) => time, ifAbsent: () => time);
    StoredVar.setDates(JsonEncoder().convert(dates));

    SettingsVar.currentTimePeriod = time;
    StoredVar.setCurrentTimePeriod(time);
  }

  static void setDailyMax(var time) {
    SettingsVar.dailyMax = time;
    StoredVar.setDailyMax(time);
  }
  static void setRollingPeriod(bool time) {
    SettingsVar.rollingPeriod = time;
    StoredVar.setRollingPeriod(time);
  }
  static void editHours(var hours, var day) {
    SettingsVar.dates.update('$day',
            (value) => hours, ifAbsent: () => hours);
    StoredVar.setDates(JsonEncoder().convert(dates)); //
  }
  static void setEmail(String email) {
    SettingsVar.email = email;
    StoredVar.setEmail(email);
  }
  static void setPassword(String password) {
    SettingsVar.password = password;
    StoredVar.setPassword(password);
  }



  static void changeProgress() {
    if (SettingsVar.rollingPeriod) {
      if (SettingsVar.period == 'Week') {
        int temp = 0;
        for (int i = 0; i < 7; i++) {
          temp += SettingsVar.dates['${SettingsVar.today - i}'] == null ? 0 :
          SettingsVar.dates['${SettingsVar.today - i}'];
        }
        SettingsVar.setwProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Month') {
        int temp = 0;
        for (int i = 0; i < DateUtil().daysInMonth(
            DateTime.now().month, DateTime.now().year); i++) {
          temp += SettingsVar.dates['${SettingsVar.today - i}'] == null ? 0 :
          SettingsVar.dates['${SettingsVar.today - i}'];
        }
        SettingsVar.setmProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Year') {
        int temp = 0;
        for (int i = 0; i < DateUtil().yearLength(DateTime.now().year); i++) {
          temp += SettingsVar.dates['${SettingsVar.today - i}'] == null ? 0 :
          SettingsVar.dates['${SettingsVar.today - i}'];
        }
        SettingsVar.setyProgressOfTimePeriod(temp);
      }
    } else {
      if (SettingsVar.period == 'Week') {
        int temp = 0;
        var dayNum = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;

        for (int i = 0; i < 7; i++) {
          var diff = i - dayNum;
          temp += SettingsVar.dates['${SettingsVar.today + diff}'] == null ? 0 :
          SettingsVar.dates['${SettingsVar.today + diff}'];
        }
        SettingsVar.setwProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Month') {
        int temp = 0;
        var start = DateTime.utc(DateTime.now().year, DateTime.now().month, 01).
        difference(DateTime.parse('20200101')).inDays + 1;
        var end = DateTime.utc(DateTime.now().year, DateTime.now().month  ,
            DateUtil().daysInMonth(DateTime.now().month, DateTime.now().year)
        ).difference(DateTime.parse('20200101')).inDays + 1;

        for (int i = start; i <= end; i++) {
          temp += SettingsVar.dates['$i'] == null ? 0:SettingsVar.dates['$i'];
        }
        SettingsVar.setmProgressOfTimePeriod(temp);
      } else if (SettingsVar.period == 'Year') {
        int temp = 0;
        var start = DateTime.utc(DateTime.now().year, 01 , 01)
            .difference(DateTime.parse('20200101')).inDays;
        var end = DateTime.utc(DateTime.now().year, 12 , 31)
            .difference(DateTime.parse('20200101')).inDays + 1;
        for (int i = start; i <= end; i++) {
          temp += SettingsVar.dates['$i'] == null ? 0:SettingsVar.dates['$i'];
        }
        SettingsVar.setyProgressOfTimePeriod(temp);
      }

    }
  }


  static String getUID () {
    try {
      if (user != null) {
        return user.uid;
      } else if (googleAccount != null){
        return googleAccount.id;
      }
      return '';
    } on Exception catch (e) {
      return '';
    }
  }


  static void reset() {
    dates.clear();

    setTimeFrame('Hour');
    setPeriod('Week');
    setTotalTimePeriod(70);
    setwProgressOfTimePeriod(0);
    setmProgressOfTimePeriod(0);
    setyProgressOfTimePeriod(0);
    setCurrentTimePeriod(0);
    setDailyMax(12);
    setRollingPeriod(true);
    timeFrame = 'Hour';
    timeFrameAdj = 'Hourly';
    period = 'Week';
    periodAdj = 'Weekly';
    totalTimePeriod = 70;
    wprogressOfTimePeriod = 0;
    mprogressOfTimePeriod = 0;
    yprogressOfTimePeriod = 0;
    currentTimePeriod = 0;
    dailyMax = 12;
    rollingPeriod = true;
  }


}