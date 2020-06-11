import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quotesapp/src/models/quote_data.dart';

enum LoadingState { none, loading, error }

class DataState {
  List<QuoteData> quotes = [];
  List favquotes = [];
  DocumentSnapshot list;

  LoadingState state = LoadingState.loading;

  DataState.initial();
  DataState(DataState currentState) {
    this.quotes = currentState.quotes;
    this.favquotes = currentState.favquotes;
    this.list = currentState.list;
  }
}