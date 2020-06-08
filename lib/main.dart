import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:quotesapp/screens/hom_screen.dart';


void main(){runApp(
    MaterialApp(
      theme: ThemeData(
          fontFamily: 'ComicNeue'
      ),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    )
);
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        loaderColor: Colors.transparent,
        imageBackground: AssetImage('assets/splash_screen.png'),
        seconds: 10,
        navigateAfterSeconds: MyHomePage()
    );
  }
}




