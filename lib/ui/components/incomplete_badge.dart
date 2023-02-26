import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';

class IncompleteStatusBadge extends StatefulWidget {
  Future<Library> library;

  IncompleteStatusBadge({
    super.key,
    required this.library,
  });

  @override
  State<IncompleteStatusBadge> createState() => _IncompleteStatusBadgeState();
}

class _IncompleteStatusBadgeState extends State<IncompleteStatusBadge> {
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
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Incomplete cost',
                            style: TextStyle(
                                fontSize: 18,
                                color: context.resources.color.colorWhite),
                          ),
                          Text(
                            '${snapshot.data!.libraryBooks.map((libraryBook) {
                              //   print('${libraryBook.book.price}');
                              return libraryBook.book.price;
                            }).reduce((a, b) => a + b)} Baht',
                            style: TextStyle(
                                fontSize: 18,
                                color: context.resources.color.colorWhite),
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
                            '${(snapshot.data!.incompleteCount / snapshot.data!.bookCount * 100).toStringAsFixed(1)} %',
                            style: TextStyle(
                              fontSize: 18,
                              color: context.resources.color.colorWhite,
                            ),
                          )
                        ],
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
