import 'package:flutter/material.dart';
import 'package:ontrack_time_tracker/firebase/firebaseAuth.dart';
import 'package:ontrack_time_tracker/pages/settings/variables.dart';
import 'package:ontrack_time_tracker/theme/colors.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (
        child: Column (
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
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



                      Container (
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Row (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 19.0, fontWeight: FontWeight.w700,
                                      color: ThemeColors.DarkBlue,
                                      fontFamily: 'Poppins', height: 1.2,
                                    ),
                                    children: <TextSpan> [
                                      TextSpan(text: 'Your email:  '),
                                      TextSpan(text:
                                      '${SettingsVar.email}',
                                        style: TextStyle(fontSize: 22.0,
                                            color: ThemeColors.Red),),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container (
                        padding: EdgeInsets.fromLTRB(20, 20, 30, 10),
                        child: Row (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 19.0, fontWeight: FontWeight.w700,
                                      color: ThemeColors.DarkBlue,
                                      fontFamily: 'Poppins', height: 1.2,
                                    ),
                                    children: <TextSpan> [
                                      TextSpan(text: 'Your password:  '),
                                      TextSpan(text:
                                      '${SettingsVar.password}',
                                        style: TextStyle(fontSize: 22.0,
                                            color: ThemeColors.Red),),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      


                      Container (
                        margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: ThemeColors.Red,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: RaisedButton (
                            padding: EdgeInsets.only(top: 13, bottom: 13, left: 15, right: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            color: Colors.transparent,
                            disabledColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            elevation: 0,
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                color: ThemeColors.DarkBlue,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onPressed: ()  {
                              AuthProvider().logOut();
                            },
                          )
                      ),


                    ],
                  )
              ),
            ),
          ],
        ),
      ),

    );
  }
}