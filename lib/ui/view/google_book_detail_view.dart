import 'package:flutter/material.dart';

class GoogleBookDetailView extends StatefulWidget {
  final int pageCount;
  final double price;
  final String title,
      subtitle,
      thumbnail,
      description,
      currencyCode,
      googleBookId;
  final List<String> authors, categories;

  const GoogleBookDetailView({
    super.key,
    required this.googleBookId,
    required this.pageCount,
    required this.price,
    required this.title,
    required this.subtitle,
    required this.thumbnail,
    required this.description,
    required this.currencyCode,
    required this.authors,
    required this.categories,
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
                widget.thumbnail,
              ),
            ),
            const SizedBox(height: 10),
            Text(widget.title),
            const SizedBox(height: 10),
            if (widget.authors.isEmpty) ...[
              const Text('no author')
            ] else ...[
              Text('by ${widget.authors.join(', ')}'),
            ],
            const SizedBox(height: 50),
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
