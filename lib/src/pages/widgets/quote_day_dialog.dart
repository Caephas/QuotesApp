import 'dart:io';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quotesapp/src/bloc/blocs/data_bloc.dart';
import 'package:quotesapp/src/bloc/events/data_event.dart';
import 'package:quotesapp/src/models/quote_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:quotesapp/utils/tools.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuoteDayDialog extends StatelessWidget {

  takescrshot(BuildContext context, String _downloadsDirectory, GlobalKey<ScaffoldState> scalf, GlobalKey scr) async {
    var status = await Permission.storage.request().isGranted;
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    if(status) {
      String time = new DateTime.now().microsecondsSinceEpoch.toString();
      File imgFile = new File('$_downloadsDirectory/screenshot'+time+'.png');
      imgFile.writeAsBytes(pngBytes);
    }
    Fluttertoast.showToast(
      msg: "Saved to $_downloadsDirectory",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
    );
    // final snackBar = SnackBar(
    //   content: Text('Saved to ${_downloadsDirectory.path}'),
    //   action: SnackBarAction(
    //     label: 'Ok',
    //     onPressed: () {
    //       // Some code
    //     },
    //   ),
    // );

    // scalf.currentState.showSnackBar(snackBar);
  }

  showQuotesDialog(List<QuoteData> data, BuildContext context, String downloadsDirectory, GlobalKey<ScaffoldState> scalf, int ind, GlobalKey scr, DataBloc bloc) {
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
            width: MediaQuery.of(context).size.width,
            height: (((data[ind].quote.length).toDouble())+ 370),            
            child: Scaffold(
              key: scalf,
              backgroundColor: Colors.transparent,
              body: Column(
                children: <Widget>[
                  RepaintBoundary(
                    key: scr,
                    child: Container(
                      height: (((data[ind].quote.length).toDouble())+ 370)-70, 
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)
                              ),
                              image: DecorationImage(
                                    image: AssetImage(Tools.multiImage[Random().nextInt(4)]),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
                              ),
                            ),
                            padding: const EdgeInsets.only(top:5.0, bottom: 20, left: 10, right: 10),
                            child: Column(
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
                                SizedBox(height: 10,),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.format_quote, size: 24, color: Colors.white),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            data[ind].quote,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 26, color: Colors.white, height: 1.5),
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
                                          " - " + data[ind].author,
                                          style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 22, color: Colors.white,),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),                            
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)
                      ),
                      color: Colors.white
                    ),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: data[ind].isLiked ? Colors.red : Colors.grey,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("Like")
                              ],
                            ),
                          ),
                          onTap: (){
                            bloc.add(AddFav(data[ind].quote, data[ind].isLiked, ind, bloc));
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
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
                          ),

                          onTap: () => takescrshot(context, downloadsDirectory, scalf, scr),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
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
                          ),
                          onTap: (){
                            Clipboard.setData(new ClipboardData(text: data[ind].quote+'\n'+'-'+data[ind].author));
                            Fluttertoast.showToast(
                                msg: "Text Copied Succesfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
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
                          ),
                          onTap: (){
                            Share.share(data[ind].quote+'\n'+'-'+data[ind].author);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}