import 'dart:convert';

import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/google_book.dart';
import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BookService {
  static Future<LibraryBooks> addGoogleBook(GoogleBook gBook) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.post(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/library-books/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'book_data': {
          'title': gBook.volumeInfo.title,
          'subtitle': gBook.volumeInfo.subtitle,
          'category': gBook.volumeInfo.categories.isEmpty
              ? ''
              : gBook.volumeInfo.categories[0],
          'thumbnail': gBook.volumeInfo.thumbnail,
          'description': gBook.volumeInfo.description,
          'page_count':
              gBook.volumeInfo.pageCount == -1 ? 0 : gBook.volumeInfo.pageCount,
          'currency_code': gBook.saleInfo.currencyCode.toUpperCase() == ''
              ? null
              : gBook.saleInfo.currencyCode,
          'price': gBook.saleInfo.price == -1 ? 0 : gBook.saleInfo.price,
          'google_book_id': gBook.googleBookId,
          'authors': gBook.volumeInfo.authors
              .map((author) => {'name': author})
              .toList(),
        },
        'is_completed': false,
      }),
    );

    if (response.statusCode == 201) {
      print('Add google book successfully');
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = jsonDecode(utf8Response);
      return LibraryBooks.fromJson(data);
    } else {
      print('API_ERROR: ${response.statusCode}');
      return Future.error('Something went wrong.');
    }
  }

  static Future<LibraryBooks> addCustomBook(BuildContext context) async {
    final provider = Provider.of<BookProvider>(context, listen: false);
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.post(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/library-books/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'book_data': {
          'title': provider.titleController.text,
          'subtitle': provider.subtitleController.text,
          'category': provider.categoryController.text,
          'thumbnail': provider.thumbnailController.text,
          'description': provider.descriptionController.text,
          'page_count': provider.pageCountController.text,
          'currency_code': provider.currencyCodeController.text.toUpperCase(),
          'price': provider.bookPriceController.text,
          'created_by': currentUser.uid,
          'authors': provider.authorController.text
              .trim()
              .split(',')
              .map((author) => {'name': author})
              .toList()
        },
        'is_completed': false,
      }),
    );

    if (response.statusCode == 201) {
      print('Add book successfully');
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = jsonDecode(utf8Response);
      return LibraryBooks.fromJson(data);
    } else {
      print('API_ERROR: ${response.statusCode}');
      return Future.error('Something went wrong.');
    }
  }

  static Future<void> removeBookById(int id) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.delete(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/library-books/$id/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
    );

    if (response.statusCode == 204) {
      print('Remove book successfully');
    } else {
      print('API_ERROR: ${response.statusCode}');
      return Future.error('Something went wrong.');
    }
  }

  static Future<Book> updateBook(BuildContext context, int id) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();
    final provider = Provider.of<BookProvider>(context, listen: false);

    final response = await http.patch(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/books/$id/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'title': provider.editTitleController.text,
        'subtitle': provider.editSubtitleController.text,
        'category': provider.editCategoryController.text,
        'thumbnail': provider.editThumbnailController.text,
        'description': provider.editDescriptionController.text,
        'page_count': provider.editPageCountController.text,
        'currency_code': provider.editCurrencyCodeController.text.toUpperCase(),
        'price': provider.editBookPriceController.text,
        // 'authors': provider.authorController.text
        //     .split(',')
        //     .map((author) => {'name': author})
        //     .toList()
      }),
    );

    if (response.statusCode == 200) {
      print('Update book successfully');
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = jsonDecode(utf8Response);
      return Book.fromJson(data);
    } else {
      print('API_ERROR: ${response.statusCode}');
      return Future.error('Something went wrong.');
    }
  }

  static Future<void> updateAuthor(BuildContext context, int id) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();
    final provider = Provider.of<BookProvider>(context, listen: false);

    final response = await http.patch(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/authors/$id/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'name': provider.authorController.text,
      }),
    );

    if (response.statusCode == 200) {
      print('Update book successfully');
    } else {
      print('API_ERROR: ${response.statusCode}');
    }
  }

  static Future<void> updateBookStatus(int id, bool is_completed) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.patch(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/library-books/$id/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'is_completed': is_completed,
      }),
    );

    if (response.statusCode == 200) {
      print('Update book status successfully');
    } else {
      print('API_ERROR: ${response.statusCode}');
    }
  }

  static Future<LibraryBooks> getBookDetailById(int id) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    try {
      final response = await http.get(
        Uri.parse(
            "http://${dotenv.env['BACKEND_PATH']}/api/library-books/$id/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken'
        },
      );
      if (response.statusCode == 200) {
        final utf8Response = utf8.decode(response.bodyBytes);
        final data = jsonDecode(utf8Response);
        print('Get book detail successfully');
        return LibraryBooks.fromJson(data);
      } else {
        print('API_ERROR: ${response.statusCode}');
        throw Exception('Failed to load book detail');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<Library>> getLibrary() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.get(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/library/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
    );

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = jsonDecode(utf8Response);
      return data.map<Library>((json) => Library.fromJson(json)).toList();
    } else {
      print('API_ERROR: ${response.statusCode}');
      throw Exception('Failed to load library');
    }
  }
}
