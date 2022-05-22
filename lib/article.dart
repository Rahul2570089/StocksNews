class Article {
  int? totalresults;
  String? url;
  String? urlimage;
  String? source;
  String? title;

  Article({
    this.totalresults,
    this.url,
    this.urlimage,
    this.source,
    this.title,
  });

  factory Article.fromJson(Map json) {
    return Article(
      source: json['name'],
      url: json['url'],
      urlimage: json['urlToImage'],
      title: json['title'],
    );
  }
}