import 'package:flutter/material.dart';
import 'package:ontrack_time_tracker/firebase/firebaseAuth.dart';
import 'package:ontrack_time_tracker/pages/settings/variables.dart';
import 'package:ontrack_time_tracker/theme/colors.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: SettingsVar.email);
    _passwordController = TextEditingController(text: SettingsVar.password);
  }

  showAlertDialog() {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
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
                                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                    print("Email and password are required");
                                    return;
                                  }
                                  bool res = await AuthProvider().signInWithEmail(_emailController.text, _passwordController.text);
                                  if (!res) {
                                    showAlertDialog();
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
                                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                    print("Email and password are required");
                                    return;
                                  }
                                  bool res = await AuthProvider().signUpWithEmail(_emailController.text, _passwordController.text);
                                  if (!res) {
                                    showAlertDialog();
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
                              if (!res) {
                                showAlertDialog();
                                print("failed");
                              }
                            },
                          )
                      ),
                    ),


                    Container (
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

                    Container (
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
                            if (!res) {
                              showAlertDialog();
                              print("failed");
                            }
                          },
                        )
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
