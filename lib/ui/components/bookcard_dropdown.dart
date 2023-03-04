import 'package:dokudoku/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class BookCardDropdown extends StatefulWidget {
  final int libraryBookId;
  final void Function(bool) libraryBookStatusUpdateCallback;
  bool bookStatus;

  BookCardDropdown({
    super.key,
    required this.libraryBookId,
    required this.libraryBookStatusUpdateCallback,
    required this.bookStatus,
  });

  @override
  State<BookCardDropdown> createState() => _BookCardDropdownState();
}

class _BookCardDropdownState extends State<BookCardDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.028,
      width: MediaQuery.of(context).size.width * 0.33,
      child: DropdownButtonFormField(
        items: <String>['Incomplete', 'Completed']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        value: widget.bookStatus ? "Completed" : "Incomplete",
        onChanged: dropdownCallback,
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: context.resources.color.colorDarkest,
          size: 20,
        ),
        borderRadius: BorderRadius.circular(20),
        isExpanded: true,
        isDense: true,
        style: TextStyle(
          fontSize: 10,
          color: context.resources.color.colorDarkest,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.check,
            color: context.resources.color.positive,
            size: 20,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0,
            horizontal: MediaQuery.of(context).size.width * 0.01,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: context.resources.color.colorDarkest),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: context.resources.color.colorDarkest),
          ),
        ),
      ),
    );
  }

  void dropdownCallback(String? selectedValue) async {
    String currentStatus = widget.bookStatus ? 'Completed' : 'Incomplete';
    if (selectedValue is String && selectedValue != currentStatus) {
      await BookService.updateBookStatus(
        widget.libraryBookId,
        selectedValue == 'Completed' ? true : false,
      );

      if (selectedValue == "Completed") {
        widget.bookStatus = true;
      } else if (selectedValue == "Incomplete") {
        widget.bookStatus = false;
      }

      widget.libraryBookStatusUpdateCallback(widget.bookStatus);
    }
  }
}
