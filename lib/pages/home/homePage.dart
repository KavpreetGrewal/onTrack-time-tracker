import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'CircularProgressBar.dart';
import '../../theme/colors.dart';
import '../settings/settingsPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.White,
        body: SingleChildScrollView(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(bottom: 30, top: 0),
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: ThemeColors.LightBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 5.0,

                        )
                      ]
                  ),
                child: Column(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(10, 0),
                      child: Container(
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
                    ),

                  Padding (
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text (
                              '${SettingsVar.periodAdj} Hours:',
                                  style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.w700,
                                  )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Row(
                            children: <Widget>[
                              Text (
                                  '${SettingsVar.currentTimePeriod} ',
                                style: TextStyle(fontSize: 45.0,
                                        fontWeight: FontWeight.bold,
                                    color: ThemeColors.Red),
                              ),
                              Text (
                                '/ ',
                                  style: TextStyle(
                                    fontSize: 15.0, fontWeight: FontWeight.w700,
                                  )
                              ),
                              Text (
                                  '${SettingsVar.totalTimePeriod}',
                                  style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.w700,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                    CustomPaint (
                      foregroundPainter: CircularProgressBar(
                          SettingsVar.progressOfTimePeriod.toDouble() /
                              SettingsVar.totalTimePeriod.toDouble() * 100),
                      child: Container(
                          width: 200,
                          height: 200,
                          child: GestureDetector(
                              onTap: () {
                                // do something here if needed
                              },
                              child: Center(child: Text(
                                "${(SettingsVar.progressOfTimePeriod /
                                    SettingsVar.totalTimePeriod * 100).toInt()}%",
                                style: TextStyle (
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                ),))
                          )
                      ),
                    ),
                  ],
                )
              ),


              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                height: MediaQuery.of(context).size.height - 500,
                decoration: BoxDecoration(
                  color: ThemeColors.LightBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 5.0,

                    )
                  ]
                ),
                child: Center (
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w600,
                          color: ThemeColors.DarkBlue,
                        ),
                        children: <TextSpan> [
                          TextSpan(text: 'Hours remaining in the week: '),
                          TextSpan(text: '${SettingsVar.currentTimePeriod}',
                            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),),
                        ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add, color: ThemeColors.DarkBlue,),
          backgroundColor: ThemeColors.Red,
        ),
    );
  }
}