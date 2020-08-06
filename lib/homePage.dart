import 'package:flutter/material.dart';
import 'CircularProgressBar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double currentHours = 30;
  double maxHours = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomPaint (
                foregroundPainter: CircularProgressBar(currentHours / maxHours * 100),
                child: Container(
                    width: 200,
                    height: 200,
                    child: GestureDetector(
                        onTap: () {
                          // do something here if needed
                        },
                        child: Center(child: Text("${currentHours.toInt()} / ${maxHours.toInt()}",
                          style: TextStyle (
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),))
                    )
                ),
              ),
              Text(
                '${currentHours.toInt()}',
                // style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        )
    );
  }
}