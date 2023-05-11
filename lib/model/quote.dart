class Quote {
  final String q, a, h;

  const Quote({
    required this.q,
    required this.a,
    required this.h,
  });

  factory Quote.fromJson(json) {
    return Quote(
      q: json['q'],
      a: json['a'],
      h: json['h'],
    );
  }

  Map<String, dynamic> toJson() => {
        'q': q,
        'a': a,
        'h': h,
      };
}
