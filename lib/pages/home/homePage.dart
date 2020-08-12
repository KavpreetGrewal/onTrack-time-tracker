import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'CircularProgressBar.dart';
import '../../theme/colors.dart';
import '../settings/variables.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



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
    this.setState(() {
      if (SettingsVar.period == 'Week') {
        SettingsVar.setwProgressOfTimePeriod(text);
      }
      if (SettingsVar.period == 'Month') {
        SettingsVar.setmProgressOfTimePeriod(text);
      }
      if (SettingsVar.period == 'Year') {
        SettingsVar.setyProgressOfTimePeriod(text);
      }
    });
  }

  int getProgress () {
    var progress;
    this.setState(() {
      if (SettingsVar.period == 'Week') {
        progress = SettingsVar.wprogressOfTimePeriod;
      }
      if (SettingsVar.period == 'Month') {
        progress = SettingsVar.mprogressOfTimePeriod;
      }
      if (SettingsVar.period == 'Year') {
        progress = SettingsVar.yprogressOfTimePeriod;
      }
    });
    return progress;
  }

  void setCurrentTimePeriod (var text) {
    this.setState(() {
      SettingsVar.setCurrentTimePeriod(text);
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
      if (SettingsVar.period == 'Week') {
        if (rolling) {
          temp = 6;
        } else {
          temp = 6 - now.weekday;
          if (temp == 0) {
            temp = 6;
          }
        }
        if (SettingsVar.currentTimePeriod == 0) {
          temp += 1;
        }
      } else if (SettingsVar.period == 'Month') {
        if (rolling) {
          temp = DateUtil().daysInMonth(DateTime.now().month, DateTime.now().year) - 1;
        } else {
          temp = DateUtil().daysInMonth(DateTime.now().month, DateTime.now().year) - DateTime.now().day;
        }
        if (SettingsVar.currentTimePeriod == 0) {
          temp += 1;
        }
      } else if (SettingsVar.period == 'Year') {
        if (rolling) {
          temp = DateTime.utc(DateTime.now().year, 12, 31).difference(DateTime.utc(DateTime.now().year, 01, 01)).inDays - 1;
        } else {
          temp = DateTime.now().difference(DateTime.utc(DateTime.now().year, 01, 01)).inDays;
        }
        if (SettingsVar.currentTimePeriod == 0) {
          temp += 1;
        }
      }
    });
    return temp.toInt() == 0 ? 1:temp.toInt();
  }

  var controller = new TextEditingController(text: '${SettingsVar.currentTimePeriod}');

  createAlertDialog(BuildContext context) {
    @override
    void initState() {
      super.initState();
      controller.text = '${SettingsVar.currentTimePeriod}'; // Setting the initial value for the field.
    }

    return showDialog(context: context, barrierDismissible: false, builder: (context) {
      return AlertDialog(
          title: Text("Log Today's Hours"),
          backgroundColor: ThemeColors.White,
          content: Container(
            padding: EdgeInsets.only(right: 30, left: 30),
            child: TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              controller: this.controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              cursorColor: ThemeColors.Red,
              decoration: InputDecoration(
                prefix: IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: ThemeColors.Red,),
                  onPressed: () {
                    int current = int.parse(controller.text);
                    controller.text = '${--current}';
                  },
                ),
                suffix: IconButton(
                  icon: Icon(Icons.add_circle_outline, color: ThemeColors.Red,),
                  onPressed: () {
                    int current = int.parse(controller.text);
                    controller.text = '${++current}';
                  },
                ),
              ),
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
              setCurrentTimePeriod(int.parse(controller.text));
              Navigator.of(context).pop(controller.text.toString());
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
                                  '${getProgress()} ',
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
                          getProgress().toDouble() /
                              SettingsVar.totalTimePeriod.toDouble() * 100),
                      child: Container(
                          width: 200,
                          height: 200,
                          child: GestureDetector(
                              onTap: () {
                                // do something here if needed
                              },
                              child: Center(child: Text(
                                "${(getProgress() /
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
                                        getProgress()) ~/
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
                                    style: TextStyle(height: 1.5),)
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
        floatingActionButton: FloatingActionButton.extended (
          onPressed: () => {
            createAlertDialog(context)
          },
          tooltip: 'Log Hours',
          icon: Icon(Icons.add, color: ThemeColors.DarkBlue,),
          label: Text (
            'Log Hours',
            style: TextStyle(
              color: ThemeColors.DarkBlue,
            ),
          ),
          backgroundColor: ThemeColors.Red,
        ),
    );
  }

}

