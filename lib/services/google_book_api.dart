import 'dart:convert';
import 'package:dokudoku/model/google_book.dart';
import 'package:http/http.dart' as http;

class FetchGoogleBook {
  static Future<List<GoogleBook>> getBookList(String query) async {
    query = query.replaceAll(' ', '+');
    String fetchUrl =
        'https://www.googleapis.com/books/v1/volumes?q=$query&printType=books&maxResults=40';

    final url = Uri.parse(fetchUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = json.decode(utf8Response)['items'];
      return data.map<GoogleBook>(GoogleBook.fromJson).toList();
    } else {
      print('api error: ${response.statusCode}');
      throw Exception('Failed to load books');
    }
  }

  static Future<GoogleBook> getGoogleBookDetail(String? id) async {
    String fetchUrl = 'https://www.googleapis.com/books/v1/volumes/$id';
    final url = Uri.parse(fetchUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = json.decode(utf8Response);
      return GoogleBook.fromJson(data);
    } else {
      print('api error: ${response.statusCode}');
      throw Exception('Failed to load books detail');
    }
  }

  static Future<List<GoogleBook>> getBookByIsbn(String scanResult) async {
    String fetchUrl =
        'https://www.googleapis.com/books/v1/volumes?q=isbn:$scanResult';

    final url = Uri.parse(fetchUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = json.decode(utf8Response)['items'];
      print('yedma');
      return data.map<GoogleBook>(GoogleBook.fromJson).toList();
    } else {
      print('api error: ${response.statusCode}');
      throw Exception('Failed to load books');
    }
  }
}
