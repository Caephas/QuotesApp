import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotesapp/src/bloc/blocs/data_bloc.dart';
import 'package:quotesapp/src/bloc/states/data_state.dart';

class QuoteDay extends StatefulWidget {
  static const String routeName = "/quoteday";
  @override
  _QuoteDayState createState() => _QuoteDayState();
}

class _QuoteDayState extends State<QuoteDay> {
  var _dataBloc = DataBloc();
  int index;
  @override
  void initState() {
    super.initState();
    setState(() {
      index = _dataBloc.quoteIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: _dataBloc,
          builder: (context, state) {
            return Container();
          }
      ),
    );
  }
}