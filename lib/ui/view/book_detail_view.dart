import 'package:dokudoku/model/author.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/edit_book_dialog.dart';
import 'package:flutter/material.dart';

class BookDetailView extends StatefulWidget {
  final int id, pageCount;
  final double price;
  final String title,
      subtitle,
      category,
      thumbnail,
      description,
      currencyCode,
      googleBookId;
  final List<Author> author;
  final bool isCompleted;

  const BookDetailView({
    super.key,
    required this.id,
    required this.pageCount,
    required this.price,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.thumbnail,
    required this.description,
    required this.currencyCode,
    required this.author,
    required this.googleBookId,
    required this.isCompleted,
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
            if (widget.googleBookId.isEmpty) ...[
              IconButton(
                onPressed: () {
                  editBookDialog.editBookPopup(
                    context,
                    widget.id,
                    widget.pageCount,
                    widget.price,
                    widget.title,
                    widget.subtitle,
                    widget.category,
                    widget.thumbnail,
                    widget.description,
                    widget.currencyCode,
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
                widget.thumbnail,
                errorBuilder: ((context, error, stackTrace) =>
                    Image.asset('assets/images/default_book_cover.png')),
              ),
            ),
            const SizedBox(height: 10),
            Text(widget.title),
            const SizedBox(height: 10),
            if (widget.author.isEmpty) ...[
              const Text('No author details')
            ] else ...[
              Text(
                  'by ${widget.author.map((author) => author.name).join(', ')}'),
            ],
            const SizedBox(height: 50),
            if (widget.isCompleted) ...[
              const Text('Reading Status: Complete'),
            ] else ...[
              const Text('Reading Status: Incomplete'),
            ],
            const SizedBox(height: 10),
            if (widget.price < 0) ...[
              const Text('Price: No price details')
            ] else ...[
              Text('Price: ${widget.price.toString()}'),
            ],
            const SizedBox(height: 10),
            Text('Book Page: ${widget.pageCount.toString()}'),
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
