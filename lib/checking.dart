import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(new MaterialApp(
  theme:
  ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
)); // MaterialApp

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => print("Team Flash Splash Done!!!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.redAccent),
            ), // container
            Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Icon(
                            Icons.flash_auto,
                            color: Colors.yellowAccent,
                            size: 50.0,
                          ) // Icon
                      ), // CircleAvater
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ), // Padding
                      Text(
                        "Team-Flash",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold), // style
                      ) // Text
                    ], // <Widget>[]
                  ), // Column
                ), // Container
              ), // Expanded
              Expanded(
                flex: 1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ), // paddign
                      Text("""
Your Flash Quotes \n\t\t\t\t\t\t\t\t Easy Way""",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold) // style
                      ) // text
                    ] // <widget>[]
                ), // coulmn
              ) // exapanded
            ]),
          ], // <Widget>[]
        ) //Stack
    ); // scaffold
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Screen"),
      ),
    );
  }
}
