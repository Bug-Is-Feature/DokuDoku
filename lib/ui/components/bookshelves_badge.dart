import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';

class BookshelvesBadge extends StatefulWidget {
  Future<Library> library;

  BookshelvesBadge({
    super.key,
    required this.library,
  });

  @override
  State<BookshelvesBadge> createState() => _BookshelvesBadgeState();
}

class _BookshelvesBadgeState extends State<BookshelvesBadge> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          color: context.resources.color.colorDark,
          borderRadius: BorderRadius.circular(80),
          boxShadow: List.generate(
            3,
            (index) => BoxShadow(
              color: context.resources.color.grey,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ),
        ),
        child: FutureBuilder<Library>(
          future: widget.library,
          builder: (BuildContext context, AsyncSnapshot<Library> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : snapshot.data?.libraryBooks.isEmpty ?? true
                    ? incompleteBadgeRow(
                        context,
                        '0 Baht',
                        '0 %',
                      )
                    : incompleteBadgeRow(
                        context,
                        '${snapshot.data!.libraryBooks.map((libraryBook) => libraryBook.isCompleted ? 0 : libraryBook.book.price).reduce((a, b) => a + b).toStringAsFixed(2)} Baht',
                        '${(snapshot.data!.incompleteCount / snapshot.data!.bookCount * 100).toStringAsFixed(1)} %',
                      );
          },
        ),
      ),
    );
  }
}

Widget incompleteBadgeRow(
    BuildContext context, String incompleteCost, String incompletePercent) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Incomplete cost',
            style: TextStyle(
                fontSize: 18, color: context.resources.color.colorWhite),
          ),
          Text(
            incompleteCost,
            style: TextStyle(
                fontSize: 18, color: context.resources.color.colorWhite),
          )
        ],
      ),
      VerticalDivider(
        color: context.resources.color.colorDarkest,
        thickness: 2,
        indent: 18,
        endIndent: 18,
        width: 2,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Incomplete percent",
            style: TextStyle(
              fontSize: 18,
              color: context.resources.color.colorWhite,
            ),
          ),
          Text(
            incompletePercent,
            style: TextStyle(
              fontSize: 18,
              color: context.resources.color.colorWhite,
            ),
          )
        ],
      )
    ],
  );
}
