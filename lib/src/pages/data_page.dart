import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotesapp/src/bloc/blocs/data_bloc.dart';
import 'package:quotesapp/src/bloc/events/data_event.dart';
import 'package:quotesapp/src/bloc/states/data_state.dart';
import 'package:quotesapp/src/pages/widgets/quote_card.dart';
import 'package:quotesapp/utils/tools.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  var _dataBloc = DataBloc();
  ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =new GlobalKey<RefreshIndicatorState>();
  int ind;

  @override
  void initState() { 
    super.initState();
    _dataBloc.quoteIndex = Tools.prefs.getInt('no') ?? 0;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          if(!_dataBloc.nomore) {
            _dataBloc.add(FetchMoreData(_dataBloc));
          }
      }
    });
    Future.delayed(Duration.zero, () {
      _dataBloc.add(FetchData(_dataBloc, Tools.prefs.getString('date')));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DataBloc, DataState>(
        bloc: _dataBloc,
        builder: (context, state) {
          if(state.state == LoadingState.loading)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if(state.state == LoadingState.none)
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.quotes.length,
                  itemBuilder: (context, index) {
                    return index == state.quotes.length-1 ? 
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          width: _dataBloc.nomore ? 0 : 20,
                          height: _dataBloc.nomore ? 0 : 20,
                          child: _dataBloc.nomore ? SizedBox(height: 0,) : CircularProgressIndicator(strokeWidth: 2,),
                        ),
                      ],
                    ) :  QuoteCard(quote: state.quotes[index].quote, author: state.quotes[index].author, isLiked: state.quotes[index].isLiked, index: index, data: state.quotes, context: context);
                  },
                ),
              ),
            );
          else
            return Center(child: Text('There Was an Error'),);
        },
      ),
    );
  }
  Future<Null> _refresh() async {
    Future.delayed(Duration.zero, () {
      FetchData(_dataBloc, Tools.prefs.getString('date'));
    });
  }
}