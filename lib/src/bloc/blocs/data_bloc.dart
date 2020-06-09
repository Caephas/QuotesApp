import 'package:bloc/bloc.dart';
import 'package:quotesapp/src/bloc/events/data_event.dart';
import 'package:quotesapp/src/bloc/states/data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  static final DataBloc _dataBlocSingleton = DataBloc._internal();

  factory DataBloc(){
    return _dataBlocSingleton;
  }

  DataBloc._internal();

  @override
  get initialState => DataState.initial();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    final newState = DataState(state);
    if(event is FetchData) {
      newState.state = LoadingState.loading;
      yield newState;
    }
    if(event is FetchDataSuccess) {
      newState.state = LoadingState.none;
      newState.quotes = event.quotes;
      yield newState;
    }
    if(event is AddFav) {
      newState.state = LoadingState.none;
      yield newState;
    }
    if(event is AddFavSuccess) {
      newState.state = LoadingState.none;
      newState.quotes[event.index].isLiked = !event.fav;
      yield newState;
    }
    if(event is FetchFav) {
      newState.state = LoadingState.loading;
      yield newState;
    }
    if(event is FetchFavSuccess) {
      newState.state = LoadingState.none;
      newState.favquotes = event.favquotes;
      yield newState;
    }
  }  
}

@override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }