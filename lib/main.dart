import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:quotesapp/screens/hom_screen.dart';
import 'package:flutter/services.dart';


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

  static const statusBar = const Color(0xff4A55A4);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBar, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      body: SplashScreen(
          loaderColor: Colors.transparent,
          imageBackground: AssetImage('assets/splash_screen.png'),
          seconds: 5,
          navigateAfterSeconds: MyHomePage()
      ),
    );
  }
}




