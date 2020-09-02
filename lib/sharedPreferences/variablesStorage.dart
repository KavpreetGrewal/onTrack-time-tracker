import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/settings/variables.dart';
import 'package:firebase_database/firebase_database.dart';

class StoredVar {
  static final firebaseDB = FirebaseDatabase.instance.reference();




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
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('timeFrame').once().then(
//            (DataSnapshot data){
//          SettingsVar.timeFrame = data.value ?? 'Hour';
//          return data;
//        });
//    if (ds.value != null) {
//      ds.value.forEach((key, value) => {
//        SettingsVar.timeFrame = value ?? 'Hour'
//      });
//    }
  }
  static Future<void> setTimeFrame(String timeFrame) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('timeFrame', timeFrame);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('timeFrame').set({'timeFrame': timeFrame});
  }


  static void getPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.period = prefs.getString('period') ?? 'Week';
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('period').once().then(
//            (DataSnapshot data){
//          SettingsVar.period = data.value ?? 'Week';
//          return data;
//        });
  }
  static Future<void> setPeriod(String period) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('period', period);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('period').set({'period': period});
  }


  static void getTotalTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.totalTimePeriod = prefs.getInt('totalTimePeriod')?? 70;
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('totalTimePeriod').once().then(
//            (DataSnapshot data){
//          SettingsVar.totalTimePeriod = data.value ?? 70;
//          return data;
//        });
  }
  static Future<void> setTotalTimePeriod(int totalTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalTimePeriod', totalTimePeriod);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('totalTimePeriod').set({'totalTimePeriod': totalTimePeriod});
  }


  static void getwprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.wprogressOfTimePeriod = prefs.getInt('wprogressOfTimePeriod') ?? 0;
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('wprogressOfTimePeriod').once().then(
//            (DataSnapshot data){
//          SettingsVar.wprogressOfTimePeriod = data.value ?? 0;
//          return data;
//        });
  }
  static Future<void> setwprogressOfTimePeriod(int wprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('wprogressOfTimePeriod', wprogressOfTimePeriod);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('wprogressOfTimePeriod').set({'wprogressOfTimePeriod': wprogressOfTimePeriod});
  }


  static void getmprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.mprogressOfTimePeriod = prefs.getInt('mprogressOfTimePeriod') ?? 0;
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('mprogressOfTimePeriod').once().then(
//            (DataSnapshot data){
//          SettingsVar.mprogressOfTimePeriod = data.value ?? 0;
//          return data;
//        });
  }
  static Future<void> setmprogressOfTimePeriod(int mprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mprogressOfTimePeriod', mprogressOfTimePeriod);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('mprogressOfTimePeriod').set({'mprogressOfTimePeriod': mprogressOfTimePeriod});
  }


  static void getyprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.yprogressOfTimePeriod = prefs.getInt('yprogressOfTimePeriod') ?? 0;
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('yprogressOfTimePeriod').once().then(
//            (DataSnapshot data){
//          SettingsVar.yprogressOfTimePeriod = data.value ?? 0;
//          return data;
//        });
  }
  static Future<void> setyprogressOfTimePeriod(int yprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('yprogressOfTimePeriod', yprogressOfTimePeriod);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('yprogressOfTimePeriod').set({'yprogressOfTimePeriod': yprogressOfTimePeriod});
  }


  static void getCurrentTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.currentTimePeriod = prefs.getInt('currentTimePeriod') ?? 0;
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('currentTimePeriod').once().then(
//            (DataSnapshot data){
//          SettingsVar.currentTimePeriod = data.value ?? 0;
//          return data;
//        });
  }
  static Future<void> setCurrentTimePeriod(int currentTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentTimePeriod', currentTimePeriod);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('currentTimePeriod').set({'currentTimePeriod': currentTimePeriod});
  }


  static void  getDailyMax() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.dailyMax = prefs.getInt('dailyMax') ?? 12;
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('dailyMax').once().then(
//            (DataSnapshot data){
//          SettingsVar.dailyMax = data.value ?? 12;
//          return data;
//        });
  }
  static Future<void> setDailyMax(int dailyMax) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyMax', dailyMax);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('dailyMax').set({'dailyMax': dailyMax});
  }


  static void getRollingPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.rollingPeriod = prefs.getBool('rollingPeriod') ?? true;
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('rollingPeriod').once().then(
//            (DataSnapshot data){
//          SettingsVar.rollingPeriod = data.value ?? true;
//          return data;
//        });
  }
  static Future<void> setRollingPeriod(bool rollingPeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rollingPeriod', rollingPeriod);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('rollingPeriod').set({'rollingPeriod': rollingPeriod});
  }


  static void getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.email = prefs.getString('email') ?? '';
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('email').once().then(
//            (DataSnapshot data){
//          SettingsVar.email = data.value ?? '';
//          return data;
//        });
  }
  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('email').set({'email': email});
  }


  static void getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.password = prefs.getString('password') ?? '';
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('password').once().then(
//            (DataSnapshot data){
//          SettingsVar.password = data.value ?? '';
//          return data;
//        });
  }
  static Future<void> setPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('password').set({'password': password});
  }


  static void getDates() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.dates = JsonDecoder().convert(prefs.getString('dates')) ?? new Map<String, dynamic>();
//    String uid = SettingsVar.getUID();
//    DataSnapshot ds = await firebaseDB.child('${uid}/').child('dates').once().then(
//            (DataSnapshot data){
//          SettingsVar.dates = JsonDecoder().convert(data.value) ?? new Map<String, dynamic>();
//          return data;
//        });
  }
  static Future<void> setDates(String dates) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dates', dates);
//    String uid = SettingsVar.getUID();
//    firebaseDB.child('${uid}/').child('dates').set({'dates': dates});
  }


}