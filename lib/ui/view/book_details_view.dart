import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:dokudoku/ui/components/edit_book_dialog.dart';
import 'package:dokudoku/ui/view/bookshelves_view.dart';
import 'package:flutter/material.dart';

class BookDetailsView extends StatefulWidget {
  final LibraryBooks libraryBook;
  const BookDetailsView({super.key, required this.libraryBook});

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
                image: Image.network(widget.libraryBook.book.thumbnail).image,
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.libraryBook.book.title,
                        style: TextStyle(
                            fontSize: 20,
                            color: context.resources.color.colorWhite),
                      ),
                      Text(
                        widget.libraryBook.book.subtitle,
                        style: TextStyle(
                            fontSize: 12,
                            color: context.resources.color.greyLight),
                      ),
                      if (widget.libraryBook.book.authors.isEmpty) ...[
                        Text(
                          'No author details',
                          style: TextStyle(
                            color: context.resources.color.colorWhite,
                            fontSize: 12,
                          ),
                        )
                      ] else ...[
                        Text(
                          'by ${widget.libraryBook.book.authors.map((author) => author.name).join(', ')}',
                          style: TextStyle(
                            color: context.resources.color.colorWhite,
                            fontSize: 12,
                          ),
                        ),
                      ],
                      Text(
                        "${widget.libraryBook.book.pageCount} pages",
                        style: TextStyle(
                            fontSize: 12,
                            color: context.resources.color.colorWhite),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          await BookService.updateBook(context,
                                              widget.libraryBook.book.id);

                                          if (!mounted) return;
                                          Navigator.of(context).pop();

                                          setState(() {
                                            widget.libraryBook.book;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Custom book updated successfully'),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.brown[400],
                                        ),
                                        child: const Text('Edit'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
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
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                            color: context.resources.color.colorWhite,
                          ),
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
                                      await BookService.removeBookById(
                                          widget.libraryBook.libraryBookId);
                                      setState(() {
                                        widget.libraryBook.libraryBookId;
                                      });
                                      if (!mounted) return;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BookShelvesView(),
                                        ),
                                      );
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
