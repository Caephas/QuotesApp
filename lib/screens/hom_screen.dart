
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const heartLikedColor = const Color(0xfff44336);
  static const heartUnLikedColor = const Color(0xffc6c4c4);
  Color favorite = heartUnLikedColor;
//  static const textColor = const Color(0xff373737);

  static const textColorWhite = const Color(0xffffffff);
  static const iconColor = const Color(0xffffffff);
  static const themeColor = const Color(0xff4a55a4);

  String value;
  String dailyQuote = "Whatever you are, be a good one.";
  String author = "-Abraham Lincoln";
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

  void close(BuildContext context){
    Navigator.pop(context);
  }

  showQuotesDialog({String quotes, String author, BuildContext context}) {



    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)
              )
          ),
          contentPadding: EdgeInsets.all(0.0),
          content: Container(
            height: MediaQuery.of(context).size.height / 1.7,
            child: Column(

              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          ),
                          image: DecorationImage(
                              image: AssetImage("assets/waterfall.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
                          ),
                        ),
                      ),

                      Container(
                        height: 600,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top:5.0, bottom: 5, left: 10, right: 10),
                        child: ListView(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.stars, color: Colors.white,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Quotes of the day",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),



                            Icon(Icons.format_quote, size: 24, color: Colors.white),

                            SizedBox(
                              height: 10,
                            ),

                            Center(

                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  quotes,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),

                                ),
                              ),
                            ),


                            SizedBox(
                              height: 10,
                            ),

                            Icon(Icons.format_quote, size: 24, color: Colors.white,),

                            SizedBox(
                              height: 15,
                            ),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                " - " + author,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            )

                          ],
                        ),
                      )

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: <Widget>[
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.favorite, color: Colors.grey,),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Like")
                          ],
                        ),

                        onTap: (){},
                      ),
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.save_alt),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Save Image")
                          ],
                        ),

                        onTap: (){},
                      ),
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.content_copy),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Copy text")
                          ],
                        ),
                        onTap: (){},
                      ),
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.share),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Share")
                          ],
                        ),
                        onTap: (){},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                  color: themeColor
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Align(
                          child: Text(
                            dailyQuote,
                            style: TextStyle(
                              color: textColorWhite,
                              fontSize: 16,
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                        ),
                        Align(
                          child: Text(
                            author,
                            style: TextStyle(
                                color: textColorWhite,
                                fontSize: 12,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: themeColor,
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/sky.png"
                            ),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.stars,
                            color: iconColor,
                          ),
                          title: Text(
                            "Quote of the day",
                            style: TextStyle(
                                color: textColorWhite
                            ),
                          ),
                          onTap: () {
                            close(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                              Icons.favorite,
                              color: iconColor),
                          title: Text(
                            "Liked Quotes",
                            style: TextStyle(
                                color: textColorWhite
                            ),
                          ),
                          onTap: () {
                            close(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                              Icons.phone,
                              color: iconColor
                          ),
                          title: Text(
                            "Contact Us",
                            style: TextStyle(
                                color: textColorWhite
                            ),
                          ),
                          onTap: () {
                            close(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                              Icons.share,
                              color: iconColor
                          ),
                          title: Text(
                            "Share App",
                            style: TextStyle(
                                color: textColorWhite
                            ),
                          ),
                          onTap: () {
                            close(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                              Icons.star,
                              color: iconColor
                          ),
                          title: Text(
                            "Rate Us",
                            style: TextStyle(
                                color: textColorWhite
                            ),
                          ),
                          onTap: () {
                            close(context);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
        appBar: AppBar(
          title: Text("iMotivate"),
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 2.0, bottom: 3.0),
                child: InkWell(
                  onTap: (){
                    showQuotesDialog(quotes: "Lorem", author: "Muhammed Ali", context: context);
                  },
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
                                  color: textColorWhite
                              )
                          )),),
                        SizedBox(height: 3.0,),
                        Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(" Muhammad Ali",
                            style: TextStyle(
                                fontSize: 17.5,
                                color: textColorWhite
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
                ),
              );
            })
    );
  }

}

