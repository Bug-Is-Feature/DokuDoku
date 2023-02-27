import 'dart:async';

import 'package:dokudoku/model/google_book.dart';
import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/services/google_book_api.dart';
import 'package:dokudoku/ui/components/search.dart';
import 'package:dokudoku/ui/components/search_book_card_widget.dart';
import 'package:dokudoku/ui/view/google_book_detail_view.dart';
import 'package:flutter/material.dart';

class SearchGoogleBookView extends StatefulWidget {
  Future<Library> library;
  final void Function(bool, LibraryBooks) addCallback, removeCallback;

  SearchGoogleBookView({
    super.key,
    required this.library,
    required this.addCallback,
    required this.removeCallback,
  });

  @override
  State<SearchGoogleBookView> createState() => _SearchGoogleBookViewState();
}

class _SearchGoogleBookViewState extends State<SearchGoogleBookView> {
  List<GoogleBook> books = [];
  List<String> idList = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    _getIdList();
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void _getIdList() {
    widget.library.then((value) => setState(() => idList = value.libraryBooks
        .map((libraryBook) => libraryBook.book.googleBookId)
        .toList()));
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Search Books'),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: <Widget>[
          buildSearch(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return GoogleBookSearchCard(
                  book: book,
                  imageHeight: 100.0,
                  imageWidth: 64.0,
                  idList: idList,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleBookDetailView(
                          googleBook: book,
                        ),
                      ),
                    );
                  },
                  onPressed: (bool isAdd) async {
                    String error = '';

                    if (isAdd) {
                      LibraryBooks libraryBook =
                          await BookService.addGoogleBook(book)
                              .catchError((e) => error = e);
                      if (error.isEmpty) {
                        setState(() => idList.add(book.googleBookId));
                        widget.addCallback(error.isEmpty, libraryBook);
                      } else {
                        print(error);
                      }
                    } else {
                      final libraryBook = await widget.library.then((value) =>
                          value
                              .libraryBooks
                              .where((libraryBook) =>
                                  libraryBook.book.googleBookId ==
                                  book.googleBookId)
                              .first);

                      await BookService.removeBookById(
                              libraryBook.libraryBookId)
                          .catchError((e) => error = e);

                      if (error.isEmpty) {
                        setState(() => idList.remove(book.googleBookId));
                        widget.removeCallback(error.isEmpty, libraryBook);
                      } else {
                        print(error);
                      }
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        if (query.trim() != '') {
          final books = await FetchGoogleBook.getBookList(query);

          if (!mounted) return;

          setState(() {
            this.query = query;
            this.books = books;
          });
        }
      });
}
