import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quotesapp/src/bloc/blocs/data_bloc.dart';
import 'package:quotesapp/src/bloc/events/data_event.dart';
import 'package:quotesapp/src/models/quote_data.dart';
import 'package:quotesapp/src/pages/widgets/quote_dialog.dart';
import 'package:quotesapp/utils/constants.dart';
import 'package:share/share.dart';

class QuoteCard extends StatefulWidget {
  final String quote;
  final String author;
  final bool isLiked;
  final int index;
  final List<QuoteData> data;
  final BuildContext context;

  const QuoteCard({Key key, this.quote, this.author, this.isLiked, this.index, this.data, this.context}) : super(key: key);
  @override
  _QuoteCardState createState() => _QuoteCardState(quote, author, isLiked, index, data, context);
}

class _QuoteCardState extends State<QuoteCard> {
  final String quote;
  final String author;
  final bool isLiked;
  final int index;
  final List<QuoteData> data;
  final BuildContext context;
  
  var _dataBloc = DataBloc();
  int ind;

  _QuoteCardState(this.quote, this.author, this.isLiked, this.index, this.data, this.context);

  Widget quoteCard(String quote, String author, bool isLiked, int index, List<QuoteData> _data, BuildContext context) {
    List<QuoteData> data = _data;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.5,
      child: InkWell(
        onTap: (){
          setState(() {
            ind=index;
          });
          Navigator.of(context).push(
            new PageRouteBuilder(
                opaque: false,
                barrierColor: Colors.black.withOpacity(0.5),
                barrierDismissible: true,
                pageBuilder: (BuildContext context, __, _) {
                    return QuoteDialog(data: data, index: index);
                }
            )
          );
          // quoteDialog(quotes: quote, author: author, context: context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  '“'+quote+'”',
                  style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 20, color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: Text(
                  '-' + author,
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: data[index].isLiked ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {
                      _dataBloc.add(AddFav(quote, data[index].isLiked, index, _dataBloc));
                    }
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String item){
                      itemAction(item, quote, author, context, index, data);
                    },
                    itemBuilder: (BuildContext context) {
                      return Constants.items.map((String item){
                        return PopupMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return quoteCard(quote, author, isLiked, index, data, context);
  }

  void itemAction(String item, String quote, String author, BuildContext context, int index, List<QuoteData> _data){
    if(item == Constants.Share){
      Share.share(quote+'\n'+'-'+author);
    }
    else if(item == Constants.Copy){
      Clipboard.setData(new ClipboardData(text: quote+'\n'+author));
      final snackBar = SnackBar(
        content: Text('Text Copied Succesfully'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code
          },
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }else{
      Navigator.of(context).push(
        new PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.black.withOpacity(0.5),
            barrierDismissible: true,
            pageBuilder: (BuildContext context, __, _) {
                return QuoteDialog(data: data, index: index);
            }
        )
      );
    }

  }
}