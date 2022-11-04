class Article2 {
  String? name;
  String? symbol;
  int? no;

  Article2({this.name, this.symbol, this.no});

  factory Article2.fromJson(Map json) {
    return Article2(
      name: json["Company Name"],
      symbol: json["Symbol"],
    );
  }

  factory Article2.fromJsonn(Map json) {
    return Article2(
      name: json["Security Name"],
      symbol: json["Security Id"],
      no: json["Security Code"]
    );
  }

  factory Article2.securityno(Map json) {
    return Article2(
      symbol: json["Security Id"],
      no: json["Security Code"]
    );
  }
}

