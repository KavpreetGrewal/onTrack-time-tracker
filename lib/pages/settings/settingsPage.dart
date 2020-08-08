import 'package:flutter/material.dart';

class SettingsVar {
  static var timeFrame = 'hour';
  static var timeFrameAdj = 'Hourly';
  static var period = 'week';
  static var periodAdj = 'Weekly';
  static var totalTimePeriod = 70;
  static var progressOfTimePeriod = 10;
  static var currentTimePeriod = 0;
  static var rollingPeriod = true;
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
