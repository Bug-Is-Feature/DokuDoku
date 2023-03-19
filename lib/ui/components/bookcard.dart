import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:dokudoku/ui/components/bookcard_dropdown.dart';
import 'package:dokudoku/ui/view/book_details_view.dart';
import 'package:dokudoku/ui/view/bookshelves_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class BookCard extends StatefulWidget {
  LibraryBooks libraryBook;
  final void Function(bool) libraryBookStatusUpdateCallback;
  final void Function(bool, Book) bookUpdateCallback;
  final void Function(bool, LibraryBooks) libraryBookRemoveCallback;

  BookCard({
    super.key,
    @PathParam() required this.libraryBook,
    @PathParam() required this.bookUpdateCallback,
    @PathParam() required this.libraryBookRemoveCallback,
    @PathParam() required this.libraryBookStatusUpdateCallback,
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.router.push(
          BookDetailsRoute(
              libraryBook: widget.libraryBook,
              bookUpdateCallback: widget.bookUpdateCallback,
              libraryBookRemoveCallback: widget.libraryBookRemoveCallback),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.resources.color.colorWhite,
          boxShadow: [
            BoxShadow(
              color: context.resources.color.grey,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60 * 1.6,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: context.resources.color.greyDarker,
                    offset: const Offset(
                      1.5,
                      1.0,
                    ),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ]),
                child: Image.network(
                  widget.libraryBook.book.thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: ((context, error, stackTrace) => Image.asset(
                        'assets/images/book_cover.png',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      widget.libraryBook.book.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          color: context.resources.color.colorDarkest),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Text(
                      widget.libraryBook.book.authors
                          .map((author) => author.name)
                          .join(', '),
                      style: TextStyle(color: context.resources.color.greyDark),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0005,
                    ),
                    //Drop Down  show if in bookshelf
                    Row(
                      children: [
                        BookCardDropdown(
                          libraryBookId: widget.libraryBook.libraryBookId,
                          bookStatus: widget.libraryBook.isCompleted,
                          libraryBookStatusUpdateCallback:
                              widget.libraryBookStatusUpdateCallback,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.timer_outlined,
                            color: context.resources.color.colorDarkest,
                            size: 30,
                          ),
                          onPressed: () {
                            context.navigateTo(
                              TimerRoute(
                                children: [
                                  TimerModeTabBarRoute(
                                      id: widget.libraryBook.book.id,
                                      title: widget.libraryBook.book.title)
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // show if in bookshelf
            ],
          ),
        ),
      ),
    );
  }
}
