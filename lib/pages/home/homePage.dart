import 'package:flutter/material.dart';
import 'CircularProgressBar.dart';
import '../../theme/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double currentHours = 30;
  double maxHours = 60;
  int hoursToday = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              width: 175,
              padding: EdgeInsets.only(bottom: 25, top: 30,),
              decoration: BoxDecoration(
                color: ThemeColors.Lavender,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90.0),
                  bottomRight: Radius.circular(90.0),
                ),
              ),
              child: Center(
                child: Text (
                  'OnTrack',
                  style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'You have:',
                  style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Center (
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.w600,
                      color: ThemeColors.DarkBlue,
                    ),
                    children: <TextSpan> [
                      TextSpan(text: '$hoursToday',
                        style: TextStyle(fontSize: 40.0,
                          fontWeight: FontWeight.bold, color: ThemeColors.Blue),),
                      TextSpan(text: '  hours remaining today')
                    ]
                  ),
                ),
              ),
            ),

            CustomPaint (
              foregroundPainter: CircularProgressBar(currentHours / maxHours * 100),
              child: Container(
                  width: 200,
                  height: 200,
                  child: GestureDetector(
                      onTap: () {
                        // do something here if needed
                      },
                      child: Center(child: Text("${(currentHours/ maxHours * 100).toInt()}%",
                        style: TextStyle (
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),))
                  )
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Center (
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.w600,
                        color: ThemeColors.DarkBlue,
                      ),
                      children: <TextSpan> [
                        TextSpan(text: 'Hours remaining in the week: '),
                        TextSpan(text: '$hoursToday',
                          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),),
                      ]
                  ),
                ),
              ),
            ),
          ],

        )
    );
  }
}