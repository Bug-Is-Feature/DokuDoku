import 'package:dokudoku/model/google_book.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Book Detail'),
          ),
          backgroundColor: Colors.brown[400],
        ),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              child: Image.network(
                widget.googleBook.volumeInfo.thumbnail,
              ),
            ),
            const SizedBox(height: 10),
            Text(widget.googleBook.volumeInfo.title),
            const SizedBox(height: 10),
            if (widget.googleBook.volumeInfo.authors.isEmpty) ...[
              const Text('no author')
            ] else ...[
              Text('by ${widget.googleBook.volumeInfo.authors.join(', ')}'),
            ],
            const SizedBox(height: 50),
            if (widget.googleBook.saleInfo.price < 0) ...[
              const Text('Price: No price details')
            ] else ...[
              Text('Price: ${widget.googleBook.saleInfo.price.toString()}'),
            ],
            const SizedBox(height: 10),
            Text(
                'Book Page: ${widget.googleBook.volumeInfo.pageCount.toString()}'),
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
