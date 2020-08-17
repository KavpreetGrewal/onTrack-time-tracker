import 'dart:collection';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/settings/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoredVar {
  static final firestoreDB = Firestore.instance.collection("OnTrack").document('Test');

  static String uid = SettingsVar.getUID();

  static void getLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.loggedIn = prefs.getBool('loggedIn') ?? false;
//    await firestoreDB.collection(uid).document('loggedIn').get().then((value){
//      SettingsVar.setLoggedIn(value.data['loggedIn'] ?? false);
//    }).catchError((){SettingsVar.setLoggedIn(false);});
  }
  static Future<void> setLoggedIn(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', loggedIn);
//    await firestoreDB.collection(uid).document('loggedIn')
//        .setData({'loggedIn' : loggedIn});
  }


  static void getTimeFrame() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.timeFrame = prefs.getString('timeFrame') ?? 'Hour';
//    await firestoreDB.collection(uid).document('timeFrame').get().then((value){
//      SettingsVar.setTimeFrame(value.data['timeFrame'] ?? 'Hour');
//    }).catchError((){SettingsVar.setTimeFrame('Hour');});
  }
  static Future<void> setTimeFrame(String timeFrame) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('timeFrame', timeFrame);
//    await firestoreDB.collection(uid).document('timeFrame')
//        .setData({'timeFrame' : timeFrame});
  }


  static void getPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.period = prefs.getString('period') ?? 'Week';
//    await firestoreDB.collection(uid).document('period').get().then((value){
//      SettingsVar.setPeriod(value.data['period'] ?? 'Week');
//    }).catchError((){SettingsVar.setPeriod('Week');});
  }
  static Future<void> setPeriod(String period) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('period', period);
//    await firestoreDB.collection(uid).document('period')
//        .setData({'period' : period});
  }


  static void getTotalTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.totalTimePeriod = prefs.getInt('totalTimePeriod')?? 70;
//    await firestoreDB.collection(uid).document('totalTimePeriod').get().then((value){
//      SettingsVar.setTotalTimePeriod(value.data['totalTimePeriod'] ?? 70);
//    }).catchError((){SettingsVar.setTotalTimePeriod(70);});
  }
  static Future<void> setTotalTimePeriod(int totalTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalTimePeriod', totalTimePeriod);
//    await firestoreDB.collection(uid).document('totalTimePeriod')
//        .setData({'totalTimePeriod' : totalTimePeriod});
  }


  static void getwprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.wprogressOfTimePeriod = prefs.getInt('wprogressOfTimePeriod') ?? 0;
//    await firestoreDB.collection(uid).document('wprogressOfTimePeriod').get().then((value){
//      SettingsVar.setwProgressOfTimePeriod(value.data['wprogressOfTimePeriod'] ?? 0);
//    }).catchError((){SettingsVar.setwProgressOfTimePeriod(0);});
  }
  static Future<void> setwprogressOfTimePeriod(int wprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('wprogressOfTimePeriod', wprogressOfTimePeriod);
//    await firestoreDB.collection(uid).document('wprogressOfTimePeriod')
//        .setData({'wprogressOfTimePeriod' : wprogressOfTimePeriod});
  }


  static void getmprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.mprogressOfTimePeriod = prefs.getInt('mprogressOfTimePeriod') ?? 0;
//    await firestoreDB.collection(uid).document('mprogressOfTimePeriod').get().then((value){
//      SettingsVar.setmProgressOfTimePeriod(value.data['mprogressOfTimePeriod'] ?? 0);
//    }).catchError((){SettingsVar.setmProgressOfTimePeriod(0);});
  }
  static Future<void> setmprogressOfTimePeriod(int mprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mprogressOfTimePeriod', mprogressOfTimePeriod);
//    await firestoreDB.collection(uid).document('mprogressOfTimePeriod')
//        .setData({'mprogressOfTimePeriod' : mprogressOfTimePeriod});

  }


  static void getyprogressOfTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.yprogressOfTimePeriod = prefs.getInt('yprogressOfTimePeriod') ?? 0;
//    await firestoreDB.collection(uid).document('yprogressOfTimePeriod').get().then((value){
//      SettingsVar.setyProgressOfTimePeriod(value.data['yprogressOfTimePeriod'] ?? 0);
//    }).catchError((){SettingsVar.setyProgressOfTimePeriod(0);});
  }
  static Future<void> setyprogressOfTimePeriod(int yprogressOfTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('yprogressOfTimePeriod', yprogressOfTimePeriod);
//    await firestoreDB.collection(uid).document('yprogressOfTimePeriod')
//        .setData({'yprogressOfTimePeriod' : yprogressOfTimePeriod});

  }


  static void getCurrentTimePeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.currentTimePeriod = prefs.getInt('currentTimePeriod') ?? 0;
//    await firestoreDB.collection(uid).document('currentTimePeriod').get().then((value){
//      SettingsVar.setCurrentTimePeriod(value.data['currentTimePeriod'] ?? 0);
//    }).catchError((){SettingsVar.setCurrentTimePeriod(0);});
  }
  static Future<void> setCurrentTimePeriod(int currentTimePeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentTimePeriod', currentTimePeriod);
//    await firestoreDB.collection(uid).document('currentTimePeriod')
//        .setData({'currentTimePeriod' : currentTimePeriod});

  }


  static void  getDailyMax() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.dailyMax = prefs.getInt('dailyMax') ?? 12;
//    await firestoreDB.collection(uid).document('dailyMax').get().then((value){
//      SettingsVar.setDailyMax(value.data['dailyMax'] ?? 12);
//    }).catchError((){SettingsVar.setDailyMax(12);});
  }
  static Future<void> setDailyMax(int dailyMax) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyMax', dailyMax);
//    await firestoreDB.collection(uid).document('dailyMax')
//        .setData({'dailyMax' : dailyMax});

  }


  static void getRollingPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.rollingPeriod = prefs.getBool('rollingPeriod') ?? true;
//    await firestoreDB.collection(uid).document('rollingPeriod').get().then((value){
//      SettingsVar.setRollingPeriod(value.data['rollingPeriod'] ?? true);
//    }).catchError((){SettingsVar.setRollingPeriod(true);});
  }
  static Future<void> setRollingPeriod(bool rollingPeriod) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rollingPeriod', rollingPeriod);
//    await firestoreDB.collection(uid).document('rollingPeriod')
//        .setData({'rollingPeriod' : rollingPeriod});
  }


  static void getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.email = prefs.getString('email') ?? '';
//    await firestoreDB.collection(uid).document('email').get().then((value){
//      SettingsVar.setEmail(value.data['email'] ?? '');
//    }).catchError((){SettingsVar.setEmail('');});
  }
  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
//    await firestoreDB.collection(uid).document('email')
//        .setData({'email' : email});
  }


  static void getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.password = prefs.getString('password') ?? '';
//    await firestoreDB.collection(uid).document('password').get().then((value){
//      SettingsVar.setPassword(value.data['password'] ?? '');
//    }).catchError((){SettingsVar.setPassword('');});
  }
  static Future<void> setPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
//    await firestoreDB.collection(uid).document('password')
//        .setData({'password' : password});
  }


  static void getDates() async {
    final prefs = await SharedPreferences.getInstance();
    SettingsVar.dates = JsonDecoder().convert(prefs.getString('dates')) ?? new Map<String, dynamic>();
//    await firestoreDB.collection(uid).document('dates').get().then((value){
//      SettingsVar.dates = JsonDecoder().convert(value.data['dates']) ?? new Map<String, dynamic>();
//    }).catchError((){SettingsVar.dates = new Map<String, dynamic>();});
  }
  static Future<void> setDates(String dates) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dates', dates);
//    await firestoreDB.collection(uid).document('dates')
//        .setData({'dates' : dates});
  }

}