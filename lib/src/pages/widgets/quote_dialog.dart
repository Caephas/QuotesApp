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

class QuoteDialog extends StatefulWidget {
  final List<QuoteData> data;
  final int index;

  const QuoteDialog({Key key, this.data, this.index}) : super(key: key);

  @override
  _QuoteDialogState createState() => _QuoteDialogState(data, index);
}

class _QuoteDialogState extends State<QuoteDialog> {
  final List<QuoteData> data;
  final int index;
  GlobalKey stickyKey = GlobalKey();

  _QuoteDialogState(this.data, this.index);

  int ind;
  var _dataBloc = DataBloc();
  GlobalKey scr = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 
  Directory _downloadsDirectory;

  @override
  void initState() {
    super.initState();
    setState(() {
      ind=index;
    });
    initDownloadsDirectoryState();
  }

  Future<void> initDownloadsDirectoryState() async {
    Directory downloadsDirectory;
    try {
      downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    } on PlatformException {
      print('Could not get the downloads directory');
    }
    if (!mounted) return;

    setState(() {
      _downloadsDirectory = downloadsDirectory;
    });
  }

  takescrshot(BuildContext context) async {
    var status = await Permission.storage.request().isGranted;
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    if(status) {
      String time = new DateTime.now().microsecondsSinceEpoch.toString();
      File imgFile = new File('${_downloadsDirectory.path}/screenshot'+time+'.png');
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

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DataBloc, DataState>(
        bloc: _dataBloc,
        builder: (context, state){
            return GestureDetector(
              onTap: (){Navigator.pop(context);},
              child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          width: MediaQuery.of(context).size.width,
                          height: (((data[ind].quote.length).toDouble())+ 370),
                          child: GestureDetector(
                            onTap: (){},
                            child: Column(
                              children: <Widget>[
                                RepaintBoundary(
                                  key: scr,
                                  child: Container(                                    
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
                                                MainAxisAlignment.end,
                                                children: <Widget>[
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
                                          _dataBloc.add(AddFav(data[ind].quote, data[ind].isLiked, ind, _dataBloc));
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

                                        onTap: () => takescrshot(context),
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
                                          final snackBar = SnackBar(
                                            content: Text('Text Copied Succesfully'),
                                            action: SnackBarAction(
                                              label: 'Ok',
                                              onPressed: () {
                                                // Some code
                                              },
                                            ),
                                          );
                                          _scaffoldKey.currentState.showSnackBar(snackBar);
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
                      ),
                      Positioned(
                        top: ((MediaQuery.of(context).size.height - (((data[ind].quote.length).toDouble())+ 370))/2) + ((((data[ind].quote.length).toDouble())+ 370)/3),
                        right: 5,
                        child: GestureDetector(
                          onTap: (){
                            ind!=data.length-1 ? setState(() {
                               ind+=1;
                            }) : null;
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 30,),
                                Container(
                                  width: 20,
                                  height: 80,
                                  child: SvgPicture.asset(
                                    'assets/images/right.svg',
                                    width: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: ((MediaQuery.of(context).size.height - (((data[ind].quote.length).toDouble())+ 370))/2) + ((((data[ind].quote.length).toDouble())+ 370)/3),
                        left: 5,
                        child: GestureDetector(
                          onTap: (){
                            ind!=0 ? setState(() {
                               ind-=1;
                            }) : null;
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 80,
                                  child: SvgPicture.asset(
                                    'assets/images/left.svg',
                                    width: 10,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 30,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            );
        }
      )
    );
  }
}