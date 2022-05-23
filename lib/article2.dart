class Article2 {
  String? name;
  String? symbol;

  Article2({this.name, this.symbol});

  factory Article2.fromJson(Map json) {
    return Article2(
      name: json["name"],
      symbol: json["symbol"],
    );
  }
}
