import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class BookCard extends StatefulWidget {
  String bookName;
  String bookAuthor;
  Image bookImage;
  String bookStatus;
  //VoidCallback dropdownCallback;

  BookCard({
    super.key,
    required this.bookAuthor,
    required this.bookImage,
    required this.bookName,
    required this.bookStatus,
    // required this.dropdownCallback
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  String dropdownValue = 'Incomplete';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          color: context.resources.color.colorWhite,
          boxShadow: [
            BoxShadow(
              color: context.resources.color.grey,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.bookImage,
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  widget.bookName,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Text(widget.bookAuthor),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: context.resources.color.colorDark,
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(
                Icons.access_time_rounded,
                color: context.resources.color.colorWhite,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
