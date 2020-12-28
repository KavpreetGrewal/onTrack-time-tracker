import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home/homePage.dart';
import 'pages/calendar/calendarPage.dart';
import 'pages/settings/settingsPage.dart';
import 'pages/account/accountPage.dart';
import 'pages/account/loginPage.dart';
import 'pages/settings/variables.dart';
import 'theme/colors.dart';


// Function that runs upon the launch of the app
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: ThemeColors.DarkBlue, // navigation bar color
    statusBarColor: ThemeColors.DarkBlue, // status bar color
  ));
  SettingsVar(); // initializes system variables
  SettingsVar.changeProgress(); // updates goal progress from cloud
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnTrack - Time Tracker',
      theme: ThemeData(
        primaryColor: ThemeColors.DarkBlue,
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


// Represents the main foundation of the app
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // to switch between the page screens
  int _currentIndex = 0;
  final tabs = [
    Center(
        child: MainScreen(),
    ),
    Center(
      child: CalendarScreen(),
    ),
    Center(
      child: SettingsScreen(),
    ),
    Center(
      child: LoginScreen(),
    )
  ];

  // Builds the main nav bar and app foundation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 0, top: 0,),
        decoration: BoxDecoration(
          color: ThemeColors.DarkBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),

        // the nav bar
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


/* Classes below represent the various page screens of the app */

// Switches to main screen only if already logged in
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (SettingsVar.loggedIn) return Home();
        if (snapshot.hasData && snapshot.data != null) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}

// Switches to calendar screen only if already logged in
class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (SettingsVar.loggedIn) return Calendar();
        if (snapshot.hasData && snapshot.data != null) {
          return Calendar();
        } else {
          return Login();
        }
      },
    );
  }
}

// Switches to settings screen only if already logged in
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (SettingsVar.loggedIn) return Settings();
        if (snapshot.hasData && snapshot.data != null) {
          return Settings();
        } else {
          return Login();
        }
      },
    );
  }
}

// Switches to account screen if logged in, otherwise switches to login screen
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (SettingsVar.loggedIn) return Account();
        if (snapshot.hasData && snapshot.data != null) {
          return Account();
        } else {
          return Login();
        }
      },
    );
  }
}
