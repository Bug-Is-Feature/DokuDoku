import 'dart:async';

import 'package:dokudoku/model/google_book.dart';
import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/services/google_book_api.dart';
import 'package:dokudoku/ui/components/search_book_card_widget.dart';
import 'package:dokudoku/ui/components/search_box.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:dokudoku/ui/view/google_book_detail_view.dart';
import 'package:flutter/material.dart';

class SearchGoogleBookView extends StatefulWidget {
  Future<Library> library;
  final void Function(bool, LibraryBooks) libraryBookAddCallback,
      libraryBookRemoveCallback;
  final String isbn;

  SearchGoogleBookView({
    super.key,
    required this.library,
    required this.libraryBookAddCallback,
    required this.libraryBookRemoveCallback,
    required this.isbn,
  });

  @override
  State<SearchGoogleBookView> createState() => _SearchGoogleBookViewState();
}

class _SearchGoogleBookViewState extends State<SearchGoogleBookView> {
  List<GoogleBook> books = [];
  List<String> idList = [];
  String query = '';
  String isbn = '';
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
      body: Column(
        children: <Widget>[
          if (widget.isbn.isNotEmpty) ...[
            Container(
              decoration: BoxDecoration(
                color: context.resources.color.colorDark,
                boxShadow: [
                  BoxShadow(
                    color: context.resources.color.grey,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: buildSearchIsbn(),
              ),
            ),
          ] else ...[
            Container(
              decoration: BoxDecoration(
                color: context.resources.color.colorDark,
                boxShadow: [
                  BoxShadow(
                    color: context.resources.color.grey,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: buildSearch(),
              ),
            )
          ],
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
                      if (!mounted) return;

                      if (error.isEmpty) {
                        SnackBarUtils.showSuccessSnackBar(
                            context: context,
                            content: 'Added to incomplete shelf');
                        setState(() => idList.add(book.googleBookId));
                        widget.libraryBookAddCallback(
                            error.isEmpty, libraryBook);
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
                      if (!mounted) return;

                      if (error.isEmpty) {
                        SnackBarUtils.showSuccessSnackBar(
                            context: context, content: 'removed book');
                        setState(() => idList.remove(book.googleBookId));
                        widget.libraryBookRemoveCallback(
                            error.isEmpty, libraryBook);
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

  Widget buildSearch() => SearchBox(
      text: query,
      label: query,
      width: MediaQuery.of(context).size.width,
      onChanged: searchBook);

//    SearchWidget(
//         text: query,
//         hintText: 'Title or Author Name',
//         onChanged: searchBook,
//       );

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

  Widget buildSearchIsbn() => SearchBox(
        text: query,
        label: widget.isbn,
        width: MediaQuery.of(context).size.width,
        onChanged: searchBookByIsbn,
      );
//   SearchWidget(
//         text: widget.isbn,
//         hintText: 'Title or Author Name',
//         onChanged: searchBookByIsbn,
//       );

  Future<void> searchBookByIsbn(String isbn) async => debounce(() async {
        final books = await FetchGoogleBook.getBookByIsbn(widget.isbn);

        if (!mounted) return;

        setState(() {
          this.isbn = widget.isbn;
          this.books = books;
        });
      });
}
