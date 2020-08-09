import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'CircularProgressBar.dart';
import '../../theme/colors.dart';
import '../settings/variables.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController customController = new TextEditingController(text: '${SettingsVar.currentTimePeriod}');

  void setTimeFrame (String text) {
    this.setState(() {
      SettingsVar.setTimeFrame(text);
    });
  }

  void setPeriod (String text) {
    this.setState(() {
      SettingsVar.setPeriod(text);
    });
  }

  void setTotalTimePeriod (var text) {
    this.setState(() {
      SettingsVar.setTotalTimePeriod(text);
    });
  }

  void setProgressOfTimePeriod (var text) {
    var value = text - SettingsVar.progressOfTimePeriod;
    this.setState(() {
      setCurrentTimePeriod(value);
      SettingsVar.setProgressOfTimePeriod(text);
    });
  }

  void setCurrentTimePeriod (var text) {
    this.setState(() {
      SettingsVar.dates.update(SettingsVar.today,
              (value) => value + text, ifAbsent: () => text);
      SettingsVar.setCurrentTimePeriod(SettingsVar.dates[SettingsVar.today]);
    });
  }

  void setDailyMax (var text) {
    this.setState(() {
      SettingsVar.setDailyMax(text);
    });
  }

  void setRollingPeriod (bool text) {
    this.setState(() {
      SettingsVar.setRollingPeriod(text);
    });
  }

  int getDaysLeftInWeek (bool rolling) {
    int temp = 0;
    var now = new DateTime.now();
    this.setState(() {
      if (rolling) {
        temp = 7;
      } else {
        temp = 7 - now.weekday;
        if (temp == 0) {
          temp = 7;
        }
      }
    });
    return temp.toInt();
  }

  Future<String> createAlertDialog(BuildContext context) {

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: Text('Log Hours'),
          backgroundColor: ThemeColors.White,
          content: TextField(
            controller: customController,
            autofocus: false,
            keyboardType: TextInputType.number,
            cursorColor: ThemeColors.Red,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.remove),
              suffixIcon: Icon(Icons.add),

            ),
          ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit',
            style: TextStyle(
              color: ThemeColors.DarkBlue,
            ),),
            color: ThemeColors.Red,
            onPressed: () {
              Navigator.of(context).pop(customController.text.toString());
            },
          )
        ],
      );
    });
  }

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
                              '${SettingsVar.periodAdj} ${SettingsVar.timeFrame}s:',
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
                                  '${SettingsVar.progressOfTimePeriod} ',
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
                child: Column(
                  children: <Widget>[
                    Padding (
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text (
                                "Today's Hours:",
                                style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w700,
                                )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
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
                                    '${SettingsVar.dailyMax}',
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

                    Container (
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.w700,
                                    color: ThemeColors.DarkBlue,
                                    fontFamily: 'Poppins', height: 1.2,
                                  ),
                                  children: <TextSpan> [
                                    TextSpan(text: 'You need to log about  '),
                                    TextSpan(text:
                                    '${(SettingsVar.totalTimePeriod -
                                        SettingsVar.progressOfTimePeriod) ~/
                                        getDaysLeftInWeek(
                                            SettingsVar.rollingPeriod)}',

                                      style: TextStyle(fontSize: 25.0,
                                          fontWeight: FontWeight.w700,
                                      color: ThemeColors.Red),),
                                    TextSpan(text: '  hours each day for the next  '),
                                    TextSpan(text:
                                    '${getDaysLeftInWeek(SettingsVar.rollingPeriod)}',
                                      style: TextStyle(fontSize: 25.0,
                                          fontWeight: FontWeight.w700,
                                          color: ThemeColors.Red),),
                                    TextSpan(text: '  days to reach your goal',
                                    style: TextStyle(height: 1.3),)

                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            createAlertDialog(context).then((value) {
              setState(() {
                setCurrentTimePeriod(customController.text);
              });
            }
              )
          },
          tooltip: 'Increment',
          child: Icon(Icons.add, color: ThemeColors.DarkBlue,),
          backgroundColor: ThemeColors.Red,
        ),
    );
  }
}