import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const heartLikedColor = const Color(0xfff44336);
  static const heartUnLikedColor = const Color(0xffc6c4c4);
  Color favorite = heartUnLikedColor;
  static const textColor = const Color(0xff373737);

  String value;
  static const popItem = <String>['Expand', 'Copy', 'Share'];
  static List<PopupMenuItem<String>> _pop = popItem.map((String val) =>
      PopupMenuItem<String>(
        value: val,
        child: Text(val),
      )).toList();

  Color isLiked(bool isLiked) {
    if (isLiked) {
      return heartLikedColor;
    } else {
      return heartUnLikedColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("iMotivate"),
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 2.0, bottom: 3.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(
                          left: 5.0, top: 3.0, right: 5.0),
                        child: RichText(text: TextSpan(
                            text: "I hated every minute of training, but I said, Don’t quit. Suffer now and live the rest of your life as a champion.",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: textColor
                            )
                        )),),
                      SizedBox(height: 3.0,),
                      Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(" Muhammad Ali",
                          style: TextStyle(
                              fontSize: 17.5,
                              color: textColor
                          ),),
                      ),
                      SizedBox(height: 5.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.favorite,
                                color: isLiked(false),
                              ), onPressed: () {
                            setState(() {
                              favorite = heartLikedColor;
                            });
                          }),
                          Spacer(),
                          PopupMenuButton(
                              onSelected: (String val) async {
                                value = val;
                              },
                              itemBuilder: (BuildContext context) => _pop),
                          SizedBox(width: 2.0)

                        ],
                      )

                    ],
                  ),
                ),
              );
            })
    );
  }
}