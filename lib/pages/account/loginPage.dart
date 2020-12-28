import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:ontrack_time_tracker/firebase/firebaseAuth.dart';
import 'package:ontrack_time_tracker/main.dart';
import 'package:ontrack_time_tracker/pages/settings/variables.dart';
import 'package:ontrack_time_tracker/theme/colors.dart';


// Represents the Login page
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  // Initializes the Login page
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: SettingsVar.email);
    _passwordController = TextEditingController(text: SettingsVar.password);

    FirebaseAdMob.instance.initialize(appId: getAppID());
    myBanner = buildLargeBannerAd()..load();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  // Creates the alert dialog
  showAlertDialog() {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        myBanner = buildLargeBannerAd()..load();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text('${AuthProvider.error}'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  /* Methods to make the Google AdMob Banner Ad */

  String getAppID() {
    if (SettingsVar.andriod) {
      return "ca-app-pub-7363607837564702~3120686503";
    } else {
      return "ca-app-pub-7363607837564702~5172134773";
    }
  }

  String getAdID() {
    if (SettingsVar.andriod) {
      return "ca-app-pub-7363607837564702/3745472659";
    } else {
      return "ca-app-pub-7363607837564702/9927737622";
    }
  }

  BannerAd myBanner;

  BannerAd buildLargeBannerAd() {
    return BannerAd(
        adUnitId: getAdID(),
        size: AdSize.largeBanner,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myBanner
              ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 100);
          }
        });
  }

  /* End of ads section */


  // Builds the Login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (
        child: Column (
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(bottom: 30, top: 0),
                margin: EdgeInsets.only(right: 15, left: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: ThemeColors.LightBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 5.0,

                      )
                    ]
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 175,
                      padding: EdgeInsets.only(bottom: 25, top: 25,),
                      decoration: BoxDecoration(
                          color: ThemeColors.DarkBlue,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(90.0),
                            bottomRight: Radius.circular(90.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10.0, // soften the shadow
                              spreadRadius: 5.0,

                            )
                          ]
                      ),
                      child: Center(
                        child: Text (
                          'OnTrack',
                          style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700,
                            color: ThemeColors.White,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container (
                            margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: ThemeColors.Red,
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                              ),
                              child: RaisedButton (
                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                color: Colors.transparent,
                                disabledColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                ),
                                elevation: 0,
                                focusElevation: 0,
                                disabledElevation: 0,
                                highlightElevation: 0,
                                hoverElevation: 0,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: ThemeColors.DarkBlue,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                onPressed: () async {
                                  SettingsVar.setEmail(_emailController.text);
                                  SettingsVar.setPassword(_passwordController.text);
                                  if (_emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    print("Email and password are required");
                                    return;
                                  }
                                  bool res = await AuthProvider().signInWithEmail(
                                      _emailController.text,
                                      _passwordController.text);
                                  MyHomePage();
                                  if (!res) {
                                    showAlertDialog();
                                    myBanner.dispose();
                                    print("Login failed");
                                  }
                                },
                              )
                          ),

                          Container (
                            margin: EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                color: ThemeColors.Red,
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                              ),
                              child: RaisedButton (
                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                color: Colors.transparent,
                                disabledColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                elevation: 0,
                                focusElevation: 0,
                                disabledElevation: 0,
                                highlightElevation: 0,
                                hoverElevation: 0,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: ThemeColors.DarkBlue,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                onPressed: () async {
                                  SettingsVar.setEmail(_emailController.text);
                                  SettingsVar.setPassword(_passwordController.text);
                                  if (_emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    print("Email and password are required");
                                    return;
                                  }
                                  bool res = await AuthProvider().signUpWithEmail(
                                      _emailController.text,
                                      _passwordController.text);
                                  MyHomePage();
                                  if (!res) {
                                    showAlertDialog();
                                    myBanner.dispose();
                                    print("Sign up failed");
                                  }
                                },
                              )
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: SettingsVar.andriod,
                      child: Container (
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: Text (
                            'OR',
                            style: TextStyle (
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          )
                      ),
                    ),

                    Visibility(
                      visible: SettingsVar.andriod,
                      child: Container (
                        margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: ThemeColors.Red,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: RaisedButton (
                            padding: EdgeInsets.only(top: 13, bottom: 13, left: 34, right: 34),
                            color: Colors.transparent,
                            disabledColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            elevation: 0,
                            focusElevation: 0,
                            disabledElevation: 0,
                            highlightElevation: 0,
                            hoverElevation: 0,
                            child: Text(
                              'Login with Google',
                              style: TextStyle(
                                color: ThemeColors.DarkBlue,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onPressed: () async {
                              SettingsVar.setEmail(_emailController.text);
                              SettingsVar.setPassword(_passwordController.text);
                              bool res = await AuthProvider().loginWithGoogle();
                              MyHomePage();
                              if (!res) {
                                showAlertDialog();
                                myBanner.dispose();
                                print("failed");
                              }
                            },
                          )
                      ),
                    ),


                    Visibility(
                      visible: false,
                      child: Container (
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: Text (
                            'OR',
                            style: TextStyle (
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          )
                      ),
                    ),

                    Visibility(
                      visible: false,
                      child: Container (
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: RaisedButton (
                            padding: EdgeInsets.only(top: 13, bottom: 13, left: 15, right: 15),
                            color: ThemeColors.DarkBlue,
                            disabledColor: ThemeColors.DarkBlue,
                            focusColor: ThemeColors.DarkBlue,
                            hoverColor: ThemeColors.DarkBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            elevation: 0,
                            focusElevation: 0,
                            disabledElevation: 0,
                            highlightElevation: 0,
                            hoverElevation: 0,
                            child: Text(
                              'Continue without log in',
                              style: TextStyle(
                                color: ThemeColors.White,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onPressed: () async {
                              bool res = await AuthProvider().signInAnon();
                              MyHomePage();
                              if (!res) {
                                showAlertDialog();
                                myBanner.dispose();
                                print("failed");
                              }
                            },
                          )
                      ),
                    ),


                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
