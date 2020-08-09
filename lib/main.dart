import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home/homePage.dart';
import 'pages/calendar/calendarPage.dart';
import 'pages/settings/settingsPage.dart';
import 'pages/account/accountPage.dart';
import 'pages/settings/variables.dart';
import 'theme/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: ThemeColors.DarkBlue, // navigation bar color
    statusBarColor: ThemeColors.DarkBlue, // status bar color
  ));
  if (SettingsVar.dates[SettingsVar.today] == null) {
    SettingsVar.setCurrentTimePeriod(0);
  } else {
    SettingsVar.setCurrentTimePeriod(SettingsVar.dates[SettingsVar.today]);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnTrack - Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ThemeColors.DarkBlue,
              displayColor: ThemeColors.DarkBlue,
              fontFamily: 'Poppins'
          )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final tabs = [
    Center(
        child: Home(),
    ),
    Center(
      child: Calendar(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex], // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 0, top: 0,),
        decoration: BoxDecoration(
          color: ThemeColors.DarkBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: ThemeColors.Red,
          unselectedItemColor: ThemeColors.White.withOpacity(.5),
          selectedFontSize: 13,
          unselectedFontSize: 12,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: [
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(Icons.data_usage, size: 25,),
              activeIcon: Icon(Icons.data_usage, size: 27,)
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(Icons.date_range, size: 25,),
              activeIcon: Icon(Icons.date_range, size: 27,)
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(Icons.settings, size: 25,),
              activeIcon: Icon(Icons.settings, size: 27,)
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(Icons.person_outline, size: 25,),
              activeIcon: Icon(Icons.person_outline, size: 27,)
            ),
          ],
        ),
      ),
    );
  }
}