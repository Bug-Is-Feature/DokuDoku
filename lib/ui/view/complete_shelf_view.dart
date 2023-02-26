import 'package:dokudoku/ui/components/bookshelves_floating_button.dart';
import 'package:dokudoku/ui/components/search_sort_bookshelves.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dokudoku/ui/components/bookcard.dart';

class CompleteShelfView extends StatefulWidget {
  const CompleteShelfView({super.key});

  @override
  State<CompleteShelfView> createState() => _CompleteShelfViewState();
}

class _CompleteShelfViewState extends State<CompleteShelfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const BookshelvesFloatingButton(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: 50),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
                // SizedBox(height: 10),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
                // SizedBox(height: 10),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
                // SizedBox(height: 10),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
                // SizedBox(height: 10),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
                // SizedBox(height: 10),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
                // SizedBox(height: 10),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
                // SizedBox(height: 10),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
                // SizedBox(height: 10),
                // BookCard(
                //     bookAuthor: "Por Meung",
                //     bookImage: Image.network(
                //         "http://2.bp.blogspot.com/-M3pfeo9uP0s/VTZKDXO3o2I/AAAAAAAAAHg/3njfg4Th0is/s1600/book%2Blaunch.jpg"),
                //     bookName: "kjjkfdgljlsjdfla",
                //     bookStatus: "Complete"),
              ],
            ),
          ),
          Positioned(
            child: SearchSortBookshelves(),
            top: 0,
          ),
        ],
      ),
    );
  }
}
