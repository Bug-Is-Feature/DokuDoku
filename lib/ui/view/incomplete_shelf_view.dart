import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/add_book_dialog.dart';
import 'package:dokudoku/ui/components/bookcard.dart';
import 'package:dokudoku/ui/components/bookshelves_floating_button.dart';
import 'package:dokudoku/ui/components/quest_card.dart';
import 'package:dokudoku/ui/components/search_sort_bookshelves.dart';
import 'package:dokudoku/ui/view/book_detail_view.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:dokudoku/ui/view/search_google_book_view.dart';
import 'package:flutter/material.dart';

class IncompleteShelfView extends StatefulWidget {
  Future<Library> library;
//   final String type;

  IncompleteShelfView({
    super.key,
    required this.library,
    // required this.type,
  });

  @override
  State<IncompleteShelfView> createState() => _IncompleteShelfViewState();
}

class _IncompleteShelfViewState extends State<IncompleteShelfView> {
  late Future<Library> filteredLibrary = _getIncompleteLibrary();

  @override
  void initState() {
    super.initState();
    // refreshBooks();
  }

//   Future refreshBooks() async {
//     setState(() => isLoading = true);
//     setState(() => isLoading = false);
//   }

  Future<Library> _getIncompleteLibrary() async {
    // List<Library> library = await BookService.getLibrary();
    filteredLibrary = widget.library;
    // filteredLibrary = filteredLibrary.then((value) {
    //   value.libraryBooks = value.libraryBooks
    //       .where((libraryBook) => libraryBook.isCompleted == false)
    //       .toList();
    //   return value;
    // });
    // .libraryBooks
    // .removeWhere((libraryBook) => libraryBook.isCompleted == true);
    return filteredLibrary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const BookshelvesFloatingButton(),
      body: Stack(
        children: [
          FutureBuilder<Library>(
            future: _getIncompleteLibrary(),
            builder: (BuildContext context, AsyncSnapshot<Library> snapshot) {
              //   if (snapshot.connectionState != ConnectionState.waiting &&
              //       snapshot.data!.libraryBooks.isNotEmpty) {
              //     if (widget.type == 'incomplete') {
              //       snapshot.data!.libraryBooks = snapshot.data!.libraryBooks
              //           .where((libraryBook) => libraryBook.isCompleted == false)
              //           .toList();
              //     } else if (widget.type == 'completed') {
              //       snapshot.data!.libraryBooks = snapshot.data!.libraryBooks
              //           .where((libraryBook) => libraryBook.isCompleted == true)
              //           .toList();
              //     }
              //   }
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
                                const SizedBox(height: 20),
                                BookCard(
                                  libraryBook: libraryBook,
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
                              ],
                            );
                          },
                        );
            },
          ),
          Positioned(
            child: SearchSortBookshelves(),
            top: 0,
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
                Icons.bookmark_border,
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
