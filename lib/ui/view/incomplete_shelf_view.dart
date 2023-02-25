import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/components/bookcard.dart';
import 'package:dokudoku/ui/components/quest_card.dart';
import 'package:dokudoku/ui/components/search_sort_bookshelves.dart';
import 'package:dokudoku/ui/view/search_google_book_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class IncompleteShelfView extends StatefulWidget {
  const IncompleteShelfView({super.key});

  @override
  State<IncompleteShelfView> createState() => _IncompleteShelfViewState();
}

class _IncompleteShelfViewState extends State<IncompleteShelfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: context.resources.color.colorDarkest,
        icon: Icons.add,
        children: [
          SpeedDialChild(
            backgroundColor: context.resources.color.colorDark,
            child:
                Icon(Icons.search, color: context.resources.color.colorWhite),
            label: 'Search Book',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchGoogleBookView(),
              ));
            },
          ),
          SpeedDialChild(
            backgroundColor: context.resources.color.colorDark,
            child: Icon(
              Icons.my_library_add,
              color: context.resources.color.colorWhite,
            ),
            label: 'Add Book',
            onTap: () {},
          ),
          SpeedDialChild(
            backgroundColor: context.resources.color.colorDark,
            child: Icon(
              Icons.camera_alt,
              color: context.resources.color.colorWhite,
            ),
            label: 'Add Book by ISBN',
            onTap: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
                SizedBox(height: 10),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
                SizedBox(height: 10),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
                SizedBox(height: 10),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
                SizedBox(height: 10),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
                SizedBox(height: 10),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
                SizedBox(height: 10),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
                SizedBox(height: 10),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
                SizedBox(height: 10),
                BookCard(
                    bookAuthor: "Por Meung",
                    bookImage: Image.network(
                        "https://i0.wp.com/www.kruupdate.com/wp-content/uploads/2022/12/3.jpg?ssl=1"),
                    bookName: "kjjkfdgljlsjdfla",
                    bookStatus: "Complete"),
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
