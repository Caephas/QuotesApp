import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quotesapp/src/bloc/blocs/data_bloc.dart';
import 'package:quotesapp/src/bloc/states/data_state.dart';
import 'package:quotesapp/src/models/quote_data.dart';
import 'package:intl/intl.dart';
import 'package:quotesapp/utils/tools.dart';

abstract class DataEvent{}

class Auth extends DataEvent{
  Auth(DataBloc bloc, String date){
    
    authorize(bloc, date);
  }

  void authorize(DataBloc bloc, String date){
    List _quotes = [];
    String uid;
    FirebaseAuth _auth = FirebaseAuth.instance;

    Future signUp() async {
      try {
        AuthResult res = await _auth.signInAnonymously();
        FirebaseUser user = res.user;
        return user;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    signUp().then((value){
      uid = value.uid.toString();
      QuoteData quote;
      bloc.usid = value.uid.toString();
      Tools.prefs.setString('userid', value.uid.toString());
      final db = Firestore.instance;
      
      Future <List <DocumentSnapshot>> list() async {
        var data = await db.collection('quotes').orderBy('id').getDocuments();
        var docs = data.documents;
        return docs;
      }
      list().then((data) async {
        data.forEach((val) {
          quote = new QuoteData(quote: val['quote']??'Nothing', author: val['author']??'Nothing', isLiked: val['isLiked']??false, id: val['id']);
          _quotes.add(quote.toJson());
          // Map<String, dynamic> quote = {
          //   "quote": val['quote'],
          //   "author": val['author'],
          //   "isLiked": val['isLiked']
          // };
          // ref.setData(quote);
          // quote.clear();
        });
      }).then((value){
        for(int i=0; i<_quotes.length; i++){
          DocumentReference ref = db.collection(uid).document();
          ref.setData(_quotes[i]);
        }
        bloc.add(FetchData(bloc, date, uid));
      });
    });
  }
}

class FetchData extends DataEvent{
  List<QuoteData> _quotes = [];
  FetchData(DataBloc bloc, String date, String uid) {
    List<QuoteData> hold;
    fetch(bloc, hold, date, uid);
  }

  void fetch(DataBloc bloc, List<QuoteData> hold, String dateString, String uid) async{
    QuoteData quote;
    final db = Firestore.instance;
    DocumentSnapshot lit;
    Future <List <DocumentSnapshot>> list() async {
      var data = await db.collection(uid).orderBy('id').limit(12).getDocuments();
      var docs = data.documents;
      lit = docs.last;
      return docs;
    }
    list().then((data) async {
      data.forEach((val) {
        quote = new QuoteData(quote: val['quote']??'Nothing', author: val['author']??'Nothing', isLiked: val['isLiked']??false, id: val['id']);
        _quotes.add(quote);
      });
    }).then((value)async {
      if(dateString == null) {
        DateTime currentTime= DateTime.now();
        Tools.prefs.setString('date', DateFormat("dd-MM-yyyy").format(currentTime).toString());
        int ran = Random().nextInt(_quotes.length);
        bloc.quoteIndex = ran;
        Tools.prefs.setInt('no', ran);
      }else {
        var inputFormat = DateFormat("dd-MM-yyyy");
        DateTime checkedDate= inputFormat.parse(dateString);
        DateTime currentTime= DateTime.now();
        if(DateTime(checkedDate.year, checkedDate.month, checkedDate.day).difference(DateTime(currentTime.year, currentTime.month, currentTime.day)).inDays == 1) {
          Tools.prefs.setString('date', DateFormat("dd-MM-yyyy").format(currentTime).toString());
          int ran = Random().nextInt(_quotes.length);
          bloc.quoteIndex = ran;
          Tools.prefs.setInt('no', ran);
        }
      }
      bloc.add(FetchDataSuccess(_quotes, lit));
    });
    
  }
}

class FetchDataSuccess extends DataEvent {
  List<QuoteData> quotes;
  DocumentSnapshot list;
  
  FetchDataSuccess(this.quotes, this.list);
}

class FetchMoreData extends DataEvent{
  List<QuoteData> _quotes = [];
  FetchMoreData(DataBloc bloc, String uid) {
    List<QuoteData> hold;
    fetch(bloc, hold, uid);
  }

  void fetch(DataBloc bloc, List<QuoteData> hold, String uid) async{
    QuoteData quote;
    final db = Firestore.instance;
    DocumentSnapshot lit;
    Future <List <DocumentSnapshot>> list() async {
      var data = await db.collection(uid).startAfter([bloc.state.list['id']]).orderBy('id').limit(12).getDocuments();
      var docs = data.documents;
      if(docs.length < 12) {
        bloc.nomore = true;
      }
      lit = docs.last;
      return docs;
    }
    list().then((data) async {
      data.forEach((val) {
        quote = new QuoteData(quote: val['quote']??'Nothing', author: val['author']??'Nothing', isLiked: val['isLiked']??false);
        bloc.state.quotes.add(quote);
      });
    }).then((value) {
      bloc.add(FetchMoreDataSuccess(_quotes, lit));
    });
    
  }
}

class FetchMoreDataSuccess extends DataEvent {
  List<QuoteData> quotes;
  DocumentSnapshot list;
  
  FetchMoreDataSuccess(this.quotes, this.list);
}

class AddFav extends DataEvent {
  int index;
  bool fav;
  AddFav(String quote, this.fav, this.index, DataBloc bloc){
    addFav(quote, fav, bloc);
  }

  void addFav(String quote, bool fav, DataBloc bloc) async{
    
    final db = Firestore.instance;
    await db.collection(bloc.usid).where('quote', isEqualTo: quote).getDocuments().then((value) {
      value.documents.forEach((element) {
        db.collection("quotes").document(element.documentID).updateData({'isLiked': !fav}).then((value){
          bloc.add(AddFavSuccess(index, fav));
        });
      });
    });
  }
}

class AddFavSuccess extends DataEvent {
  int index;
  bool fav;

  AddFavSuccess(this.index, this.fav);
}

class FetchFav extends DataEvent {
  List<QuoteData> _fquotes = [];
  FetchFav(DataBloc bloc){
    getFav(bloc);
  }

  void getFav(DataBloc bloc){
    QuoteData fquote;
    final db = Firestore.instance;
    Future <List <DocumentSnapshot>> favList() async {
      var data = await db.collection(bloc.usid).where('isLiked', isEqualTo: true).getDocuments();
      var docs = data.documents;
      return docs;
    }
    favList().then((data){
      data.forEach((val) {
        fquote = new QuoteData(quote: val['quote']??'Nothing', author: val['author']??'Nothing', isLiked: val['isLiked']??false, id: val['id']);
        _fquotes.add(fquote);
      });
    }).then((value) {
      bloc.add(Favs(_fquotes));
    });
  }
}

class Favs extends DataEvent {
  List<QuoteData> favquotes;
  
  Favs(this.favquotes);
}