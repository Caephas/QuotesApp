import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quotesapp/drawer.dart';
import 'package:quotesapp/src/pages/data_page.dart';
import 'package:quotesapp/styles/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      appBar: AppBar(
        backgroundColor: blue,
        title: Text(
          'iMotivate',
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
            onTap: () => _scaffoldKey.currentState.openEndDrawer(),
            child: Container(
              margin: EdgeInsets.only(right: 28),
              child: SvgPicture.asset(
                'assets/images/ham.svg',
                width: 24,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      endDrawer: MainDrawer(),
      body: DataPage()
    );
  }
}