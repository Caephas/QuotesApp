import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quotesapp/src/bloc/blocs/data_bloc.dart';
import 'package:quotesapp/src/bloc/events/data_event.dart';
import 'package:quotesapp/src/bloc/states/data_state.dart';
import 'package:quotesapp/src/models/quote_data.dart';
import 'package:quotesapp/src/pages/widgets/quote_card.dart';
import 'package:quotesapp/src/pages/widgets/quote_dialog.dart';
import 'package:quotesapp/utils/constants.dart';
import 'package:share/share.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  var _dataBloc = DataBloc();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =new GlobalKey<RefreshIndicatorState>();
  int ind;

  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration.zero, () {
      _dataBloc.add(FetchData(_dataBloc));
    });
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
                  itemCount: state.quotes.length,
                  itemBuilder: (context, index) {
                    return QuoteCard(quote: state.quotes[index].quote, author: state.quotes[index].author, isLiked: state.quotes[index].isLiked, index: index, data: state.quotes, context: context);
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
      FetchData(_dataBloc);
    });
  }
}