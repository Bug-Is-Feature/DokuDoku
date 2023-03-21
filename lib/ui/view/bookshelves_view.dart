import 'dart:async';
import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/bookshelves_badge.dart';
import 'package:dokudoku/ui/components/bookshelves_tabbar.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class BookShelvesView extends StatefulWidget {
  const BookShelvesView({super.key});

  @override
  State<BookShelvesView> createState() => _BookShelvesViewState();
}

class _BookShelvesViewState extends State<BookShelvesView> {
  late Future<Library> library = _getLibrary();
  // List book = [
  //   Book(id: 0),
  //   Book(id: 1),
  //   Book(id: 2),
  // ];

  Future<Library> _getLibrary() async {
    List<Library> library = await BookService.getLibrary();
    return library[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: context.resources.color.colorLighter2,
              ),
              BookshelvesBadge(
                library: library,
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: context.resources.color.colorWhite,
              child: BookShelvesTabBar(
                library: library,
                libraryBookAddCallback:
                    (bool isSuccess, LibraryBooks libraryBook) => isSuccess
                        ? setState(() {
                            library.then((value) {
                              value.libraryBooks.add(libraryBook);
                              value.bookCount++;
                              value.incompleteCount++;
                            });
                          })
                        : SnackBarUtils.showWarningSnackBar(
                            context: context, content: 'Something went wrong'),
                libraryBookRemoveCallback:
                    (bool isSuccess, LibraryBooks libraryBook) => isSuccess
                        ? setState(() {
                            library.then((value) {
                              value.libraryBooks.remove(libraryBook);
                              libraryBook.isCompleted
                                  ? value.completedCount--
                                  : value.incompleteCount--;
                              value.bookCount--;
                            });
                          })
                        : SnackBarUtils.showWarningSnackBar(
                            context: context, content: 'Something went wrong'),
                libraryBookStatusUpdateCallback: (bool bookStatus) =>
                    setState(() {
                  bookStatus
                      ? library.then((value) {
                          value.completedCount++;
                          value.incompleteCount--;
                        })
                      : library.then((value) {
                          value.completedCount--;
                          value.incompleteCount++;
                        });
                }),
                bookUpdateCallback: (bool isSuccess, Book book) => isSuccess
                    ? setState(() {
                        library.then((value) => value.libraryBooks
                            .where((element) => element.book.id == book.id)
                            .first
                            .book = book);
                      })
                    : SnackBarUtils.showWarningSnackBar(
                        context: context, content: 'Something went wrong'),
              ),
            ),
          ),
          // Expanded(
          //   child: Container(
          //     color: context.resources.color.colorWhite,
          //     child: ListView(
          //       children: [
          //         // for (int i = 0; i < book.length; i++)
          //         //   BooKCard(
          //         //     id: i,
          //         //     onTap: () {
          //         //       context.router.push(
          //         //         BookDetailsRoute(
          //         //           bookID: book[i].id,
          //         //         ),
          //         //       );
          //         //     },
          //         //   )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

// class Book<Widget> {
//   final int id;

//   Book({required this.id});
// }

class BookCard extends StatelessWidget {
  final int id;
  final GestureTapCallback onTap;
  BookCard({required this.id, required this.onTap});

  Widget build(BuildContext context) {
    return ListTile(title: Text('Book $id'), onTap: onTap);
  }
}
