import 'package:quotesapp/src/models/quote_data.dart';

enum LoadingState { none, loading, error }

class DataState {
  List<QuoteData> quotes = [];
  List favquotes = [];

  LoadingState state = LoadingState.loading;

  DataState.initial();
  DataState(DataState currentState) {
    this.quotes = currentState.quotes;
    this.favquotes = currentState.favquotes;
  }
}