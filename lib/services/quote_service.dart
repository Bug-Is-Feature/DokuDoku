import 'dart:async';
import 'dart:convert';
import 'package:dokudoku/model/quote.dart';
import 'package:http/http.dart' as http;

class QuoteService {
  static Future<Quote> getRandomQuote() async {
    String fetchUrl = 'https://zenquotes.io/api/random';
    final url = Uri.parse(fetchUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = json.decode(utf8Response)[0];
      return Quote.fromJson(data);
    } else {
      print('api error: ${response.statusCode}');
      throw Exception('Failed to load quote');
    }
  }
}
