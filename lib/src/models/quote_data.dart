class QuoteData {
  String quote;
  String author;
  bool isLiked;
  int id;

  QuoteData({this.quote, this.author, this.isLiked, this.id});

  QuoteData.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    isLiked = json['isLiked'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote'] = this.quote;
    data['author'] = this.author;
    data['isLiked'] = this.isLiked;
    data['id'] = this.id;
    return data;
  }
}
