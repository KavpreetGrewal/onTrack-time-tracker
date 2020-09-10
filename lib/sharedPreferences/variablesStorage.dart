import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/settings/variables.dart';
import 'package:firebase_database/firebase_database.dart';

class StoredVar {
  static final firebaseDB = FirebaseDatabase.instance.reference();
  static String uid = '';

  static void getFromDB() {
    StoredVar.getDBTimeFrame();
    StoredVar.getDBPeriod();
    StoredVar.getDBTotalTimePeriod();
    StoredVar.getDBwprogressOfTimePeriod();
    StoredVar.getDBmprogressOfTimePeriod();
    StoredVar.getDByprogressOfTimePeriod();
    StoredVar.getDBCurrentTimePeriod();
    StoredVar.getDBDailyMax();
    StoredVar.getDBRollingPeriod();
    StoredVar.getDBDates();
  }

  static void getUID() async {
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? '';
  }
  static void setUID(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    StoredVar.uid = uid;
  }


  static void getLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.loggedIn = prefs.getBool('loggedIn') ?? false;
  }
  static Future<void> setLoggedIn(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', loggedIn);
  }


  static void getTimeFrame() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.timeFrame = prefs.getString('timeFrame') ?? 'Hour';
  }
  static Future<void> setTimeFrame(String timeFrame) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('timeFrame', timeFrame);

    if (uid != '') firebaseDB.child('$uid/').child('timeFrame').set(timeFrame);
  }
  static void getDBTimeFrame() async {
    DataSnapshot ds = await firebaseDB.child('$uid/').child('timeFrame').once().then(
            (DataSnapshot data){
          SettingsVar.timeFrame = data.value ?? 'Hour';
          setTimeFrame(SettingsVar.timeFrame);
          return data;
        });
//    if (ds.value != null) {
//      ds.value.forEach((key, value) => {
//        SettingsVar.timeFrame = value ?? 'Hour'
//      });
//    }
  }


  static void getPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.period = prefs.getString('period') ?? 'Week';
  }
  static Future<void> setPeriod(String period) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('period', period);

    if (uid != '') firebaseDB.child('$uid/').child('period').set(period);
  }
  static void getDBPeriod() async {
      DataSnapshot ds = await firebaseDB.child('$uid/').child('period').once().then(
            (DataSnapshot data){
              SettingsVar.period = data.value ?? 'Week';
              setPeriod(SettingsVar.period);
          return data;
            });
  }


  static void getTotalTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.totalTimePeriod = prefs.getInt('totalTimePeriod')?? 70;
  }
  static Future<void> setTotalTimePeriod(int totalTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalTimePeriod', totalTimePeriod);

    if (uid != '') firebaseDB.child('$uid/').child('totalTimePeriod').set(totalTimePeriod);
  }
  static void getDBTotalTimePeriod() async {
        DataSnapshot ds = await firebaseDB.child('$uid/').child('totalTimePeriod').once().then(
            (DataSnapshot data){
          SettingsVar.totalTimePeriod = data.value ?? 70;
          setTotalTimePeriod(SettingsVar.totalTimePeriod);
          return data;
        });
  }


  static void getwprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.wprogressOfTimePeriod = prefs.getDouble('wprogressOfTimePeriod') ?? 0.00;
  }
  static Future<void> setwprogressOfTimePeriod(double wprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('wprogressOfTimePeriod', wprogressOfTimePeriod);

    if (uid != '') firebaseDB.child('$uid/').child('wprogressOfTimePeriod').set(wprogressOfTimePeriod);
  }
  static void getDBwprogressOfTimePeriod() async {
    DataSnapshot ds = await firebaseDB.child('$uid/').child('wprogressOfTimePeriod').once().then(
            (DataSnapshot data){
          SettingsVar.wprogressOfTimePeriod = data.value ?? 0.00;
          setwprogressOfTimePeriod(SettingsVar.wprogressOfTimePeriod);
          return data;
        });
}


  static void getmprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.mprogressOfTimePeriod = prefs.getDouble('mprogressOfTimePeriod') ?? 0.00;
  }
  static Future<void> setmprogressOfTimePeriod(double mprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('mprogressOfTimePeriod', mprogressOfTimePeriod);

    if (uid != '') firebaseDB.child('$uid/').child('mprogressOfTimePeriod').set( mprogressOfTimePeriod);
  }
  static void getDBmprogressOfTimePeriod() async {
    DataSnapshot ds = await firebaseDB.child('$uid/').child('mprogressOfTimePeriod').once().then(
            (DataSnapshot data){
          SettingsVar.mprogressOfTimePeriod = data.value ?? 0.00;
          setmprogressOfTimePeriod(SettingsVar.mprogressOfTimePeriod);
          return data;
        });
  }


  static void getyprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.yprogressOfTimePeriod = prefs.getDouble('yprogressOfTimePeriod') ?? 0.00;
  }
  static Future<void> setyprogressOfTimePeriod(double yprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('yprogressOfTimePeriod', yprogressOfTimePeriod);

    if (uid != '') firebaseDB.child('$uid/').child('yprogressOfTimePeriod').set(yprogressOfTimePeriod);
  }
  static void getDByprogressOfTimePeriod() async {
    DataSnapshot ds = await firebaseDB.child('$uid/').child('yprogressOfTimePeriod').once().then(
            (DataSnapshot data){
          SettingsVar.yprogressOfTimePeriod = data.value ?? 0.00;
          setyprogressOfTimePeriod(SettingsVar.yprogressOfTimePeriod);
          return data;
        });
  }


  static void getCurrentTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.currentTimePeriod = prefs.getDouble('currentTimePeriod') ?? 0.00;
  }
  static Future<void> setCurrentTimePeriod(double currentTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('currentTimePeriod', currentTimePeriod);

    if (uid != '') firebaseDB.child('$uid/').child('currentTimePeriod').set(currentTimePeriod);
  }
  static void getDBCurrentTimePeriod() async {
    DataSnapshot ds = await firebaseDB.child('$uid/').child('currentTimePeriod').once().then(
            (DataSnapshot data){
          SettingsVar.currentTimePeriod = data.value ?? 0.00;
          setCurrentTimePeriod(SettingsVar.currentTimePeriod);
          return data;
        });
  }


  static void  getDailyMax() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.dailyMax = prefs.getInt('dailyMax') ?? 14;
  }
  static Future<void> setDailyMax(int dailyMax) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyMax', dailyMax);

    if (uid != '') firebaseDB.child('$uid/').child('dailyMax').set(dailyMax);
  }
  static void getDBDailyMax() async {
    DataSnapshot ds = await firebaseDB.child('$uid/').child('dailyMax').once().then(
            (DataSnapshot data){
          SettingsVar.dailyMax = data.value ?? 14;
          setDailyMax(SettingsVar.dailyMax);
          return data;
        });
  }


  static void getRollingPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.rollingPeriod = prefs.getBool('rollingPeriod') ?? true;
  }
  static Future<void> setRollingPeriod(bool rollingPeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rollingPeriod', rollingPeriod);

    if (uid != '') firebaseDB.child('$uid/').child('rollingPeriod').set(rollingPeriod);
  }
  static void getDBRollingPeriod() async {
    DataSnapshot ds = await firebaseDB.child('$uid/').child('rollingPeriod').once().then(
            (DataSnapshot data){
              if (data.value.runtimeType == bool) {
                SettingsVar.rollingPeriod = data.value ?? true;
              } else {
                SettingsVar.rollingPeriod = true;
              }
          setRollingPeriod(SettingsVar.rollingPeriod);
          return data;
        });
  }


  static void getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.email = prefs.getString('email') ?? '';
  }
  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }


  static void getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.password = prefs.getString('password') ?? '';
  }
  static Future<void> setPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }


  static void getDates() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.dates = JsonDecoder().convert(prefs.getString('dates')) ?? new Map<String, dynamic>();
  }
  static Future<void> setDates(String dates) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dates', dates);

    if (uid != '') firebaseDB.child('$uid/').child('dates').set(dates);
  }
  static void getDBDates() async {
    DataSnapshot ds = await firebaseDB.child('$uid/').child('dates').once().then(
            (DataSnapshot data){
          SettingsVar.dates = JsonDecoder().convert(data.value) ?? new Map<String, dynamic>();
          setDates(JsonEncoder().convert(SettingsVar.dates));
          return data;
        });
  }

}