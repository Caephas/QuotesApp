import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotesapp/src/bloc/blocs/data_bloc.dart';
import 'package:quotesapp/src/bloc/events/data_event.dart';
import 'package:quotesapp/src/bloc/states/data_state.dart';
import 'package:quotesapp/src/pages/widgets/fav_dialog.dart';
import 'package:quotesapp/styles/colors.dart';

class FavouritesPage extends StatefulWidget {
  static const String routeName = "/favourite";
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  var _dataBloc = DataBloc();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _dataBloc.add(FetchFav( _dataBloc));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: Text(
          'iMotivate',
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
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
                    itemCount: state.favquotes.length,
                    itemBuilder: (context, index) {
                      return FavCard(quote: state.favquotes[index].quote, author: state.favquotes[index].author, isLiked: state.favquotes[index].isLiked, index: index, data: state.favquotes, context: context);
                    },
                  ),
                ),
              );
            else
              return Center(child: Text('There Was an Error'),);
          },
        ),
      ),
    );
  }
  Future<Null> _refresh() async {
    Future.delayed(Duration.zero, () {
      _dataBloc.add(FetchFav( _dataBloc));
    });
  }
}