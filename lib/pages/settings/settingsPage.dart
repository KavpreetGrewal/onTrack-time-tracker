import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ontrack_time_tracker/pages/home/homePage.dart';
import 'package:ontrack_time_tracker/theme/colors.dart';
import '../settings/variables.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String text = SettingsVar.totalTimePeriod.toString();
  final controller = TextEditingController();
  final controllerCurrent = TextEditingController();

  void changeText(String text) {
    this.setState(() {
      this.text = text;
    });
  }

  List<Period> periods = Period.getPeriod();
  List<DropdownMenuItem<Period>> periodDropDownMenuItems;
  Period selectedPeriod;

  List<Rolling> rollings = Rolling.getRolling();
  List<DropdownMenuItem<Rolling>> rollingDropDownMenuItems;
  Rolling selectedRolling;

  int getPeriodIndex() {
    if (SettingsVar.period == 'Week') {
      return 0;
    } else if (SettingsVar.period == 'Month') {
      return 1;
    }
    return 2;
  }

  List<DropdownMenuItem<Period>> buildPeriodDropDownMenuItems(List periods) {
    List<DropdownMenuItem<Period>> items = List();
    for(Period period in periods) {
      items.add(DropdownMenuItem(value: period, child: Text(period.name),),);
    }
    return items;
  }

  onChangePeriodDropDownItem(Period selected) {
    setState(() {
      selectedPeriod = selected;
      SettingsVar.setPeriod(selected.name);
    });
    setState(() {
      SettingsVar.changeProgress();
    });
  }




  int getRollingIndex() {
    if (SettingsVar.rollingPeriod) {
      return 0;
    } else {
      return 1;
    }
  }

  List<DropdownMenuItem<Rolling>> buildRollingDropDownMenuItems(List rollings) {
    List<DropdownMenuItem<Rolling>> items = List();
    for(Rolling rolling in rollings) {
      items.add(DropdownMenuItem(value: rolling, child: Text(rolling.name),),);
    }
    return items;
  }

  onChangeRollingDropDownItem(Rolling selected) {
    setState(() {
      selectedRolling = selected;
      if (selected.name == 'True') {
        SettingsVar.setRollingPeriod(true);
      } else {
        SettingsVar.setRollingPeriod(false);
      }
    });
  }


  @override
  void initState() {
    periodDropDownMenuItems = buildPeriodDropDownMenuItems(periods);
    selectedPeriod = periodDropDownMenuItems[getPeriodIndex()].value;

    rollingDropDownMenuItems = buildRollingDropDownMenuItems(rollings);
    selectedRolling = rollingDropDownMenuItems[getRollingIndex()].value;

    controller.text = '${SettingsVar.totalTimePeriod}';
    controllerCurrent.text = '${SettingsVar.dailyMax}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      backgroundColor: ThemeColors.White,
      body: SingleChildScrollView(
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


          ],
        ),
      ),
    );
  }
}

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