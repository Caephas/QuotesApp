import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(new MaterialApp(
  theme:
  ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
  debugShowCheckedModeBanner: false,
  home: Quotes(),
)); // MaterialApp

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => new _QuotesState();
}

class _QuotesState extends State<Quotes> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => new MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            ), // container
            Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Quotes",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold), // style
                      ), // Text
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),

                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80.0,
                          child: Icon(
                            Icons.format_quote,
                            color: Colors.yellowAccent,
                            size: 50.0,
                          ) // Icon
                      ), // CircleAvatar
                       // Padding

                    ], // <Widget>[]
                  ), // Column
                ), // Container
              ), // Expanded
              Expanded(
                flex: 1,
                child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50.0),
                      ), // padding
                      Text("""
Your Flash Quotes \n\t\t\t\t\t\t\t\t Easy Way""",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal
                          ) // style
                      ),
                      Text("\n\n -Author's Name",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          ) // style
                      )// text
                    ] // <widget>[]
                ),
              )
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
