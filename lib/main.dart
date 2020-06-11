import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotesapp/home.dart';
import 'package:quotesapp/src/pages/favourites_page.dart';
import 'package:quotesapp/src/pages/quote_day.dart';
import 'package:quotesapp/utils/tools.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  Tools.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMotivate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto",
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'iMotivate'),
      routes: {
        FavouritesPage.routeName:(context) => FavouritesPage(),
        QuoteDay.routeName:(context) => QuoteDay(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        loaderColor: Colors.transparent,
        imageBackground: AssetImage('assets/images/splash_screen.png'),
        seconds: 5,
        navigateAfterSeconds: Home()
    );
  }
}
