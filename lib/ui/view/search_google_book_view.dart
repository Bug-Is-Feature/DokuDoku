import 'dart:async';

import 'package:dokudoku/model/google_book.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/services/google_book_api.dart';
import 'package:dokudoku/ui/components/search.dart';
import 'package:dokudoku/ui/components/search_book_card_widget.dart';
import 'package:dokudoku/ui/view/google_book_detail_view.dart';
import 'package:flutter/material.dart';

class SearchGoogleBookView extends StatefulWidget {
  const SearchGoogleBookView({super.key});

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
    // getIds();
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
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
                    onTap: (GoogleBook gBook) async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoogleBookDetailView(
                            googleBook: gBook,
                          ),
                        ),
                      );
                    },
                    onPressed: (GoogleBook gBook) async {
                      await BookService.addGoogleBook(gBook);
                      setState(() {
                        idList.add(gBook.googleBookId);
                      });
                    });
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
