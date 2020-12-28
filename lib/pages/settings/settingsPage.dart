import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ontrack_time_tracker/theme/colors.dart';
import '../settings/variables.dart';
import 'package:firebase_admob/firebase_admob.dart';

// Represents the Settings page
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String text = SettingsVar.totalTimePeriod.toString();
  final controller = TextEditingController();
  final controllerCurrent = TextEditingController();

  List<Period> periods = Period.getPeriod();
  List<DropdownMenuItem<Period>> periodDropDownMenuItems;
  Period selectedPeriod;

  List<Rolling> rollings = Rolling.getRolling();
  List<DropdownMenuItem<Rolling>> rollingDropDownMenuItems;
  Rolling selectedRolling;


  // Initializes the page
  @override
  void initState() {
    periodDropDownMenuItems = buildPeriodDropDownMenuItems(periods);
    selectedPeriod = periodDropDownMenuItems[getPeriodIndex()].value;

    rollingDropDownMenuItems = buildRollingDropDownMenuItems(rollings);
    selectedRolling = rollingDropDownMenuItems[getRollingIndex()].value;

    controller.text = '${SettingsVar.totalTimePeriod}';
    controllerCurrent.text = '${SettingsVar.dailyMax}';

    FirebaseAdMob.instance.initialize(appId: getAppID());
    myBanner = buildLargeBannerAd()..load();

    super.initState();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }



  // Updates the text displayed
  void changeText(String text) {
    this.setState(() {
      this.text = text;
    });
  }

  // Gets the index corresponding to the goal length selection
  int getPeriodIndex() {
    if (SettingsVar.period == 'Week') {
      return 0;
    } else if (SettingsVar.period == 'Month') {
      return 1;
    } else {
      return 2;
    }
  }

  // Builds the dropdown menu for time period selection
  List<DropdownMenuItem<Period>> buildPeriodDropDownMenuItems(List periods) {
    List<DropdownMenuItem<Period>> items = List();
    for(Period period in periods) {
      items.add(DropdownMenuItem(value: period, child: Text(period.name),),);
    }
    return items;
  }

  // Updates app setting based on the new selection
  onChangePeriodDropDownItem(Period selected) {
    setState(() {
      selectedPeriod = selected;
      SettingsVar.setPeriod(selected.name);
    });
    setState(() {
      SettingsVar.changeProgress();
    });
  }

  // Gets the index corresponding to the rolling or fixed Selection
  int getRollingIndex() {
    if (SettingsVar.rollingPeriod) {
      return 0;
    } else {
      return 1;
    }
  }

  // Builds the dropdown menu for rolling or fixed selection
  List<DropdownMenuItem<Rolling>> buildRollingDropDownMenuItems(List rollings) {
    List<DropdownMenuItem<Rolling>> items = List();
    for(Rolling rolling in rollings) {
      items.add(DropdownMenuItem(value: rolling, child: Text(rolling.name),),);
    }
    return items;
  }

  // Updates app settings based on user selection
  onChangeRollingDropDownItem(Rolling selected) {
    setState(() {
      selectedRolling = selected;
      if (selected.name == 'True') {
        SettingsVar.setRollingPeriod(true);
      } else {
        SettingsVar.setRollingPeriod(false);
      }
    });
    SettingsVar.changeProgress();
  }


  // Creates the alert dialog to get user input
  createAlertDialog(BuildContext context) {
    @override
    void initState() {
      super.initState(); // Setting the initial value for the field.
    }

    return showDialog(context: context, barrierDismissible: false, builder: (context) {
      return AlertDialog(
        title: Text("Edit Hours"),
        backgroundColor: ThemeColors.White,
        content: Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          child: Text (
            'Are you sure you want to reset all your stats. This will mean you '
                'will lose all your logged hours and will not be able to retrieve them.'
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: MaterialButton(
              elevation: 5.0,
              child: Text('No',
                style: TextStyle(
                  color: ThemeColors.DarkBlue,
                ),),
              color: ThemeColors.Red,
              onPressed: () {
                myBanner = buildLargeBannerAd()..load();
                Navigator.of(context).pop();
              },
            ),
          ),

          Container(
            margin: EdgeInsets.only(right: 10),
            child: MaterialButton(
              elevation: 5.0,
              child: Text('Yes',
                style: TextStyle(
                  color: ThemeColors.DarkBlue,
                ),),
              color: ThemeColors.Red,
              onPressed: () {
                myBanner = buildLargeBannerAd()..load();
                SettingsVar.reset();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    });
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


  // Builds the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      backgroundColor: ThemeColors.White,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Column (
            children: <Widget>[

              Container(
                color: ThemeColors.LightBlue.withOpacity(0.6),
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile (
                  leading: Icon(Icons.calendar_today),
                  title: Text('Period Duration'),
                  trailing: Container(
                      decoration: BoxDecoration(
                          color: ThemeColors.Red,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                    padding: EdgeInsets.only(left: 10, right: 5),
                    child: DropdownButton(
                      value: selectedPeriod,
                      items: periodDropDownMenuItems,
                      onChanged: onChangePeriodDropDownItem,
                      dropdownColor: ThemeColors.Red,
                      focusColor: ThemeColors.Red,
                      underline: SizedBox(),
                    ),
                  ),
                ),
              ),

              Container(
                color: ThemeColors.LightBlue.withOpacity(0.3),
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile (
                  leading: Icon(Icons.update),
                  title: Text('Rolling Period'),
                  subtitle: Text('Set false for a fixed period',
                    style: TextStyle(
                      fontSize: 11,
                    ),),
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: ThemeColors.Red,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    padding: EdgeInsets.only(left: 18, right: 5),
                    child: DropdownButton(
                      value: selectedRolling,
                      items: rollingDropDownMenuItems,
                      onChanged: onChangeRollingDropDownItem,
                      dropdownColor: ThemeColors.Red,
                      focusColor: ThemeColors.Red,
                      underline: SizedBox(),
                    ),
                  ),
                ),
              ),

              Container(
                color: ThemeColors.LightBlue.withOpacity(0.6),
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile (
                  leading: Icon(Icons.timelapse),
                  title: Text('Total Hours Limit'),
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: ThemeColors.Red,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    // padding: EdgeInsets.only(left: 18, right: 5),
                    child: Container(
                      width: 90,
                        child: TextField(
                          controller: controller,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          cursorColor: ThemeColors.DarkBlue,
                          onChanged: (text) {
                            SettingsVar.setTotalTimePeriod(int.parse(controller.text));
                          },
                        ),
                    ),
                  ),
                ),
              ),

              Container(
                color: ThemeColors.LightBlue.withOpacity(0.3),
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile (
                  leading: Icon(Icons.access_time),
                  title: Text('Daily Hours Limit'),
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: ThemeColors.Red,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    child: Container(
                      width: 90,
                      child: TextField(
                        controller: controllerCurrent,
                        autofocus: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        cursorColor: ThemeColors.DarkBlue,
                        onChanged: (text) {
                          SettingsVar.setDailyMax(int.parse(controllerCurrent.text));
                        },
                      ),
                    ),
                  ),
                ),
              ),

              Container (
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: ThemeColors.Red,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: RaisedButton (
                    padding: EdgeInsets.only(top: 13, bottom: 13,
                        left: 15, right: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    color: Colors.transparent,
                    disabledColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    elevation: 0,
                    child: Text(
                      'Reset Stats',
                      style: TextStyle(
                        color: ThemeColors.DarkBlue,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onPressed: ()  {
                      myBanner.dispose();
                      createAlertDialog(context);
                    },
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}


// Represents the different time periods to be selected
class Period {
  int id;
  String name;
  Period(this.id, this.name);

  static List<Period> getPeriod() {
    return <Period>[
      Period(1, 'Week'),
      Period(2, 'Month'),
      Period(3, 'Year'),
    ];
  }
}

// Represents the selections for rolling or fixed time period
class Rolling {
  int id;
  String name;
  Rolling(this.id, this.name);

  static List<Rolling> getRolling() {
    return <Rolling>[
      Rolling(1, 'True'),
      Rolling(2, 'False'),
    ];
  }
}