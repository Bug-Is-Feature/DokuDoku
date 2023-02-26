import 'package:dokudoku/model/author.dart';
import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/edit_book_dialog.dart';
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
    EditBookDialog editBookDialog = EditBookDialog();
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Book Detail'),
          ),
          actions: <Widget>[
            if (widget.libraryBook.book.googleBookId.isEmpty) ...[
              IconButton(
                onPressed: () {
                  editBookDialog.editBookPopup(
                    context,
                    widget.libraryBook.book.id,
                    widget.libraryBook.book.pageCount,
                    widget.libraryBook.book.price,
                    widget.libraryBook.book.title,
                    widget.libraryBook.book.subtitle,
                    widget.libraryBook.book.category,
                    widget.libraryBook.book.thumbnail,
                    widget.libraryBook.book.description,
                    widget.libraryBook.book.currencyCode,
                  );

                  setState(() {});
                },
                icon: const Icon(Icons.edit),
              ),
            ]
          ],
          backgroundColor: Colors.brown[400],
        ),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              child: Image.network(
                widget.libraryBook.book.thumbnail,
                errorBuilder: ((context, error, stackTrace) =>
                    Image.asset('assets/images/default_book_cover.png')),
              ),
            ),
            const SizedBox(height: 10),
            Text(widget.libraryBook.book.title),
            const SizedBox(height: 10),
            if (widget.libraryBook.book.authors.isEmpty) ...[
              const Text('No author details')
            ] else ...[
              Text(
                  'by ${widget.libraryBook.book.authors.map((author) => author.name).join(', ')}'),
            ],
            const SizedBox(height: 50),
            Text(
                'Reading Status: ${widget.libraryBook.isCompleted ? 'Completed' : 'Incomplete'}'),
            const SizedBox(height: 10),
            if (widget.libraryBook.book.price < 0) ...[
              const Text('Price: No price details')
            ] else ...[
              Text('Price: ${widget.libraryBook.book.price.toString()}'),
            ],
            const SizedBox(height: 10),
            Text('Book Page: ${widget.libraryBook.book.pageCount.toString()}'),
          ],
        ));
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
