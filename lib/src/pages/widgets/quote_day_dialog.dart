import 'dart:io';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quotesapp/src/bloc/blocs/data_bloc.dart';
import 'package:quotesapp/src/bloc/events/data_event.dart';
import 'package:quotesapp/src/bloc/states/data_state.dart';
import 'package:quotesapp/src/models/quote_data.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:quotesapp/utils/tools.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuoteDayDialog extends StatelessWidget {

  takescrshot(BuildContext context, Directory _downloadsDirectory, GlobalKey<ScaffoldState> scalf, GlobalKey scr) async {
    var status = await Permission.storage.request().isGranted;
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    if(status) {
      final directory = DownloadsPathProvider.downloadsDirectory;
      File imgFile = new File('${_downloadsDirectory.path}/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
    }
    final snackBar = SnackBar(
      content: Text('Saved to ${_downloadsDirectory.path}'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code
        },
      ),
    );

    scalf.currentState.showSnackBar(snackBar);
  }

  showQuotesDialog(List<QuoteData> data, BuildContext context, Directory downloadsDirectory, GlobalKey<ScaffoldState> scalf, int ind, GlobalKey scr, DataBloc bloc) {
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
              height: data[ind].quote.length < 70 ? (data[ind].quote.length*8).toDouble() : data[ind].quote.length < 200 ? (data[ind].quote.length*4.5).toDouble() : (data[ind].quote.length*3).toDouble(),            
            child: Scaffold(
              key: scalf,
              backgroundColor: Colors.transparent,
              body: Column(
                children: <Widget>[
                  RepaintBoundary(
                    key: scr,
                    child: Container( 
                      height: (data[ind].quote.length < 70 ? (data[ind].quote.length*8).toDouble() : data[ind].quote.length < 200 ? (data[ind].quote.length*4).toDouble() : (data[ind].quote.length*2.5).toDouble())-68,
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
                          ),
                          Container(
                            padding: const EdgeInsets.only(top:5.0, bottom: 5, left: 10, right: 10),
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
                    height: 68,
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
                          onTap: (){
                            bloc.add(AddFav(data[ind].quote, data[ind].isLiked, ind, bloc));
                          },
                        ),
                        GestureDetector(
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

                          onTap: () => takescrshot(context, downloadsDirectory, scalf, scr),
                        ),
                        GestureDetector(
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
                          onTap: (){
                            Clipboard.setData(new ClipboardData(text: data[ind].quote+'\n'+'-'+data[ind].author));
                            Fluttertoast.showToast(
                                msg: "Text Copied Succesfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                        ),
                        GestureDetector(
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