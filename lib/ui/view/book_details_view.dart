import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:dokudoku/ui/components/edit_book_dialog.dart';
import 'package:dokudoku/ui/view/bookshelves_view.dart';
import 'package:flutter/material.dart';

class BookDetailsView extends StatefulWidget {
  final LibraryBooks libraryBook;
  final void Function(bool, Book) bookUpdateCallback;
  final void Function(bool, LibraryBooks) libraryBookRemoveCallback;

  const BookDetailsView({
    super.key,
    required this.libraryBook,
    required this.bookUpdateCallback,
    required this.libraryBookRemoveCallback,
  });

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.network(
                  widget.libraryBook.book.thumbnail,
                  errorBuilder: ((context, error, stackTrace) =>
                      Image.asset('assets/images/book_cover.png')),
                ).image,
                fit: BoxFit.cover,
              ),
            ),
            // color: context.resources.color.colorDark,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 1,
                  ),
                  child: Container(
                    color:
                        context.resources.color.colorDarkest.withOpacity(0.6),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.libraryBook.book.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 30,
                            color: context.resources.color.colorWhite),
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.libraryBook.book.subtitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: context.resources.color.greyLight),
                      ),
                      SizedBox(height: 4),
                      if (widget.libraryBook.book.authors.isEmpty) ...[
                        Text(
                          'No author details',
                          style: TextStyle(
                            color: context.resources.color.colorWhite,
                            fontSize: 14,
                          ),
                        )
                      ] else ...[
                        Text(
                          'by ${widget.libraryBook.book.authors.map((author) => author.name).join(', ')}',
                          style: TextStyle(
                            color: context.resources.color.colorWhite,
                            fontSize: 14,
                          ),
                        ),
                      ],
                      SizedBox(height: 4),
                      Text(
                        "${widget.libraryBook.book.pageCount} pages",
                        style: TextStyle(
                            fontSize: 14,
                            color: context.resources.color.colorWhite),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${widget.libraryBook.book.price} ${widget.libraryBook.book.currencyCode}",
                        style: TextStyle(
                            fontSize: 14,
                            color: context.resources.color.colorWhite),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(width: 3),
                          if (widget.libraryBook.book.googleBookId.isEmpty) ...[
                            IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return EditBookDialog(
                                      libraryBook: widget.libraryBook,
                                      bookUpdateCallback:
                                          (bool isSuccess, Book editedBook) {
                                        if (isSuccess) {
                                          setState(() {
                                            widget.libraryBook.book =
                                                editedBook;
                                          });
                                          widget.bookUpdateCallback(
                                              isSuccess, editedBook);
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                              color: context.resources.color.colorWhite,
                            ),
                          ],
                          IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) => CustomDialog(
                                    title: 'Are you sure?',
                                    description: '',
                                    buttonText: 'Delete',
                                    buttonText2: 'Cancel',
                                    onPressed: () async {
                                      String error = '';
                                      await BookService.removeBookById(
                                              widget.libraryBook.libraryBookId)
                                          .catchError((e) => error = e);
                                      setState(() {
                                        widget.libraryBook.libraryBookId;
                                      });
                                      if (!mounted) return;
                                      //   Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const BookShelvesView(),
                                      //     ),
                                      //   );
                                      if (error.isEmpty) {
                                        // TODO: find a way to go back to bookshelves view
                                        Navigator.popUntil(
                                            context, (route) => route.isFirst);

                                        widget.libraryBookRemoveCallback(
                                            error.isEmpty, widget.libraryBook);
                                      }
                                    },
                                    onPressed2: () {
                                      Navigator.pop(context);
                                    }),
                              );
                            },
                            icon: const Icon(Icons.delete),
                            color: context.resources.color.colorWhite,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Center(
                child: Card(
                  elevation: 2,
                  color: context.resources.color.colorWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 6,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Image.network(
                              widget.libraryBook.book.thumbnail,
                              errorBuilder: ((context, error, stackTrace) =>
                                  Image.asset('assets/images/book_cover.png',
                                      width: 100,
                                      height: 150,
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Card(
                  elevation: 2,
                  color: context.resources.color.colorWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.87,
                                child: Text(
                                  widget.libraryBook.book.description,
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    onPressed: () {
                      AutoRouter.of(context).navigateNamed(
                          "timer/${widget.libraryBook.book.id}/${widget.libraryBook.book.title}");
                    },
                    backgroundColor: context.resources.color.colorDark,
                    size: Size(MediaQuery.of(context).size.width * 0.4, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer,
                          color: context.resources.color.colorWhite,
                        ),
                        SizedBox(width: 10),
                        Text("Timer"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
