import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/services/recommend_books_service.dart';
import 'package:flutter/material.dart';

class RecommendBooksProvider extends ChangeNotifier {
  // get All Recommend Books
  late Future<List<Book>> recommendBooks = _getRecommendBooks();
  Future<List<Book>> _getRecommendBooks() async {
    List<Book> recommendBooks = await RecommendBooksService.getRecommendBook();
    return recommendBooks;
  }
}
