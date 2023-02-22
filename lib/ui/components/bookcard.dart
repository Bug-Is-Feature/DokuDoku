import 'package:dokudoku/ui/components/dropdown_bookshelves.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class BookCard extends StatefulWidget {
  String bookName;
  String bookAuthor;
  Image bookImage;
  String bookStatus;

  BookCard({
    super.key,
    required this.bookAuthor,
    required this.bookImage,
    required this.bookName,
    required this.bookStatus,
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  String dropdownValue = 'Incomplete';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: context.resources.color.colorWhite,
        boxShadow: [
          BoxShadow(
            color: context.resources.color.grey,
            blurRadius: 2,
            offset: const Offset(0, 3),
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
                style: TextStyle(
                    fontSize: 20, color: context.resources.color.colorDarkest),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Text(
                widget.bookAuthor,
                style: TextStyle(color: context.resources.color.greyDark),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const DropdownBooksheleves()
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.10,
          ),
          Icon(
            Icons.timer_outlined,
            color: context.resources.color.colorDarkest,
            size: 30,
          ),
        ],
      ),
    );
  }
}
