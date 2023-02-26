import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/ui/components/bookcard.dart';
import 'package:dokudoku/ui/components/bookshelves_floating_button.dart';
import 'package:dokudoku/ui/components/search_sort_bookshelves.dart';
import 'package:flutter/material.dart';

class BookshelvesTabView extends StatefulWidget {
  Future<Library> library;
  final String type;
  final void Function(bool) callback;

  BookshelvesTabView({
    super.key,
    required this.library,
    required this.type,
    required this.callback,
  });

  @override
  State<BookshelvesTabView> createState() => _BookshelvesTabViewState();
}

class _BookshelvesTabViewState extends State<BookshelvesTabView> {
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
      floatingActionButton: const BookshelvesFloatingButton(),
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
                                BookCard(
                                  libraryBook: libraryBook,
                                  callback: (bool bookStatus) async {
                                    Library library = await widget.library;
                                    LibraryBooks target = library.libraryBooks
                                        .where((element) =>
                                            element.libraryBookId ==
                                            snapshot.data?.libraryBooks[index]
                                                .libraryBookId)
                                        .first;
                                    target.isCompleted = bookStatus;

                                    widget.callback(bookStatus);
                                  },
                                  //     onLongPress: () async {
                                  //       await BookService.removeBookById(
                                  //           libraryBook.libraryBookId);
                                  //       ScaffoldMessenger.of(context)
                                  //           .showSnackBar(
                                  //         const SnackBar(
                                  //           content:
                                  //               Text('removed book successfully'),
                                  //         ),
                                  //       );
                                  //       setState(() {});
                                  //     },
                                ),
                                const SizedBox(height: 20),
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
