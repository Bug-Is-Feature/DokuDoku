import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/ui/components/bookcard.dart';
import 'package:dokudoku/ui/components/bookshelves_floating_button.dart';
import 'package:dokudoku/ui/components/search_sort_bookshelves.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:flutter/material.dart';

class BookshelvesTabView extends StatefulWidget {
  Future<Library> library;
  final String type;
  final void Function(bool) libraryBookStatusUpdateCallback;
  final void Function(bool, Book) bookUpdateCallback;
  final void Function(bool, LibraryBooks) libraryBookAddCallback,
      libraryBookRemoveCallback;

  BookshelvesTabView({
    super.key,
    required this.library,
    required this.type,
    required this.libraryBookAddCallback,
    required this.libraryBookRemoveCallback,
    required this.libraryBookStatusUpdateCallback,
    required this.bookUpdateCallback,
  });

  @override
  State<BookshelvesTabView> createState() => _BookshelvesTabViewState();
}

class _BookshelvesTabViewState extends State<BookshelvesTabView> {
  String error = '';

  @override
  void initState() {
    super.initState();
  }

  Future<Library> _getFilteredLibrary() async {
    Library library = await widget.library;
    library = library.copyWith();
    if (widget.type == 'incomplete') {
      library.libraryBooks = library.libraryBooks
          .where((libraryBook) => libraryBook.isCompleted == false)
          .toList();
    } else if (widget.type == 'completed') {
      library.libraryBooks = library.libraryBooks
          .where((libraryBook) => libraryBook.isCompleted == true)
          .toList();
    }
    return library;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BookshelvesFloatingButton(
        library: widget.library,
        libraryBookAddCallback: widget.libraryBookAddCallback,
        libraryBookRemoveCallback: widget.libraryBookRemoveCallback,
      ),
      body: Stack(
        children: [
          FutureBuilder<Library>(
            future: _getFilteredLibrary(),
            builder: (BuildContext context, AsyncSnapshot<Library> snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : snapshot.data?.libraryBooks.isEmpty ?? true
                      ? const EmptyBookshelfWidget()
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data?.libraryBooks.length,
                          itemBuilder: (context, index) {
                            final libraryBook =
                                snapshot.data!.libraryBooks[index];
                            return Column(
                              children: [
                                const SizedBox(height: 14),
                                BookCard(
                                  libraryBook: libraryBook,
                                  libraryBookStatusUpdateCallback:
                                      (bool libraryBookStatus) async {
                                    Library library = await widget.library;
                                    LibraryBooks target = library.libraryBooks
                                        .where((element) =>
                                            element.libraryBookId ==
                                            snapshot.data?.libraryBooks[index]
                                                .libraryBookId)
                                        .first;
                                    target.isCompleted = libraryBookStatus;

                                    widget.libraryBookStatusUpdateCallback(
                                        libraryBookStatus);
                                  },
                                  libraryBookRemoveCallback:
                                      widget.libraryBookRemoveCallback,
                                  bookUpdateCallback: widget.bookUpdateCallback,
                                ),
                              ],
                            );
                          },
                        );
            },
          ),
          const Positioned(
            top: 0,
            child: SearchSortBookshelves(),
          ),
        ],
      ),
    );
  }
}

class EmptyBookshelfWidget extends StatelessWidget {
  const EmptyBookshelfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Click ",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            WidgetSpan(
              child: Icon(
                Icons.add_circle,
                size: 18,
              ),
            ),
            TextSpan(
              text: " to add books to the bookshelf",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
