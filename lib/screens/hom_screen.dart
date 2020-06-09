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
                ),
              );
            })
    );
  }
}