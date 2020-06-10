class QuoteData {
  String quote;
  String author;
  bool isLiked;

  QuoteData({this.quote, this.author, this.isLiked});

  QuoteData.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote'] = this.quote;
    data['author'] = this.author;
    data['isLiked'] = this.isLiked;
    return data;
  }
}
