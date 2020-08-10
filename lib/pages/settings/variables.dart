import 'dart:collection';
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
  static var progressOfTimePeriod = 0;
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
  static void setProgressOfTimePeriod(var time) {
    SettingsVar.progressOfTimePeriod = time;
  }
  static void setCurrentTimePeriod(var time) {
    SettingsVar.progressOfTimePeriod += time - SettingsVar.currentTimePeriod;
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
}