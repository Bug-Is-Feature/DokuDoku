import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/model/author.dart';
import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:dokudoku/ui/components/edit_book_dialog.dart';
import 'package:dokudoku/ui/view/bookshelves_view.dart';
import 'package:flutter/material.dart';

class BookDetailView extends StatefulWidget {
  final LibraryBooks libraryBook;

  const BookDetailView({
    super.key,
    required this.libraryBook,
  });

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.resources.color.greyDarker,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      context.resources.color.colorLighter2,
                      context.resources.color.colorWhite,
                    ],
                  ),
                ),
              ),
              Container(
                color: context.resources.color.greyDark.withOpacity(0.2),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 1.8,
                ),
                child: Container(
                  color: context.resources.color.greyDarker.withOpacity(0),
                ),
              ),
              Image.network(
                widget.libraryBook.book.thumbnail,
                errorBuilder: ((context, error, stackTrace) =>
                    Image.asset('assets/images/default_book_cover.png')),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.04,
                top: MediaQuery.of(context).size.height * 0.03,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30,
                    color: context.resources.color.colorDarkest,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Text(
          widget.libraryBook.book.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        if (widget.libraryBook.book.authors.isEmpty) ...[
          Text(
            'No author details',
            style: TextStyle(
              color: context.resources.color.greyDark,
              fontSize: 20,
            ),
          )
        ] else ...[
          Text(
            'by ${widget.libraryBook.book.authors.map((author) => author.name).join(', ')}',
            style: TextStyle(
              color: context.resources.color.greyDark,
              fontSize: 20,
            ),
          ),
        ],
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                AutoRouter.of(context).navigateNamed(
                    "timer/${widget.libraryBook.book.id}/${widget.libraryBook.book.title}");
              },
              icon: const Icon(Icons.timer),
              color: context.resources.color.colorDarkest,
              iconSize: 30,
            ),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              await BookService.updateBook(
                                  context, widget.libraryBook.book.id);
                              if (!mounted) return;
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Custom book updated successfully'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[400],
                            ),
                            child: const Text('Edit'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[400],
                            ),
                            child: const Text('No'),
                          ),
                        ],
                        title: const Text('edit Book'),
                        content: EditBookDialog(
                          libraryBook: widget.libraryBook,
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.edit),
              color: context.resources.color.colorDarkest,
              iconSize: 30,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reading Status ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: context.resources.color.colorDark),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Price",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: context.resources.color.colorDark),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Book Pages",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: context.resources.color.colorDark),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.libraryBook.isCompleted
                          ? 'Completed'
                          : 'Incomplete',
                      style: TextStyle(
                          fontSize: 20,
                          color: context.resources.color.colorDark),
                    ),
                    const SizedBox(height: 6),
                    if (widget.libraryBook.book.price < 0) ...[
                      Text(
                        'No price details',
                        style: TextStyle(
                            fontSize: 20,
                            color: context.resources.color.colorDark),
                      )
                    ] else ...[
                      Text(
                        widget.libraryBook.book.price.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: context.resources.color.colorDark),
                      ),
                    ],
                    Text(
                      widget.libraryBook.book.pageCount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: context.resources.color.colorDark),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        TextButton(
          child: Text(
            "Delete",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: context.resources.color.error,
            ),
          ),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => CustomDialog(
                  title: 'Are you sure?',
                  description: '',
                  buttonText: 'Delete',
                  buttonText2: 'Cancel',
                  onPressed: () async {
                    await BookService.removeBookById(
                        widget.libraryBook.libraryBookId);
                    setState(() {
                      widget.libraryBook.libraryBookId;
                    });
                    if (!mounted)
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BookShelvesView(),
                        ),
                      );
                  },
                  onPressed2: () {
                    Navigator.pop(context);
                  }),
            );

            setState(() {});
          },
        )
      ],
    );
  }
}

class NotFoundBookDetail extends StatelessWidget {
  const NotFoundBookDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Page Not Found",
        style: TextStyle(
            fontSize: 20, color: Colors.black, decoration: TextDecoration.none),
      ),
    );
  }
}
