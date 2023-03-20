import 'dart:ui';

import 'package:dokudoku/model/google_book.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:flutter/material.dart';

class GoogleBookDetailView extends StatefulWidget {
  final GoogleBook googleBook;

  const GoogleBookDetailView({
    super.key,
    required this.googleBook,
  });

  @override
  State<GoogleBookDetailView> createState() => _GoogleBookDetailViewState();
}

class _GoogleBookDetailViewState extends State<GoogleBookDetailView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //     appBar: AppBar(
        //       title: const Center(
        //         child: Text('Book Detail'),
        //       ),
        //       backgroundColor: Colors.brown[400],
        //     ),
        //     body: Column(
        //       children: [
        //         const SizedBox(height: 50),
        //         Container(
        //           alignment: Alignment.center,
        //           child: Image.network(
        //             widget.googleBook.volumeInfo.thumbnail,
        //           ),
        //         ),
        //         const SizedBox(height: 10),
        //         Text(widget.googleBook.volumeInfo.title),
        //         const SizedBox(height: 10),
        //         if (widget.googleBook.volumeInfo.authors.isEmpty) ...[
        //           const Text('no author')
        //         ] else ...[
        //           Text('by ${widget.googleBook.volumeInfo.authors.join(', ')}'),
        //         ],
        //         const SizedBox(height: 50),
        //         if (widget.googleBook.saleInfo.price < 0) ...[
        //           const Text('Price: No price details')
        //         ] else ...[
        //           Text('Price: ${widget.googleBook.saleInfo.price.toString()}'),
        //         ],
        //         const SizedBox(height: 10),
        //         Text(
        //             'Book Page: ${widget.googleBook.volumeInfo.pageCount.toString()}'),
        //       ],
        //     ));
        SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.network(
                  widget.googleBook.volumeInfo.thumbnail,
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.googleBook.volumeInfo.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 30,
                            color: context.resources.color.colorWhite),
                      ),
                      const SizedBox(height: 2),
                      if (widget.googleBook.volumeInfo.subtitle.isEmpty) ...[
                        Text(
                          'No subtitle',
                          style: TextStyle(
                            color: context.resources.color.colorWhite,
                            fontSize: 14,
                          ),
                        ),
                      ] else ...[
                        Text(
                          widget.googleBook.volumeInfo.subtitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              color: context.resources.color.greyLight),
                        ),
                      ],
                      const SizedBox(height: 4),
                      if (widget.googleBook.volumeInfo.authors.isEmpty) ...[
                        Text(
                          'No author',
                          style: TextStyle(
                            fontSize: 14,
                            color: context.resources.color.colorWhite,
                          ),
                        )
                      ] else ...[
                        Text(
                          'by ${widget.googleBook.volumeInfo.authors.join(', ')}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              color: context.resources.color.colorWhite),
                        ),
                      ],
                      const SizedBox(height: 4),
                      if (widget.googleBook.volumeInfo.pageCount != -1) ...[
                        Text(
                          "${widget.googleBook.volumeInfo.pageCount.toString()} pages",
                          style: TextStyle(
                              fontSize: 12,
                              color: context.resources.color.colorWhite),
                        ),
                      ] else ...[
                        Text(
                          "no pages",
                          style: TextStyle(
                              fontSize: 12,
                              color: context.resources.color.colorWhite),
                        ),
                      ]
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
                              widget.googleBook.volumeInfo.thumbnail,
                              errorBuilder: ((context, error, stackTrace) =>
                                  Image.asset('assets/images/book_cover.png')),
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
                                  widget.googleBook.volumeInfo.description,
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
            ],
          ),
        ],
      ),
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
