import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
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
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.04,
        // width: MediaQuery.of(context).size.width * 0.40,
        child: DropdownButtonFormField(
          items: <String>['Incomplete', 'Completed']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                  child: Text(
                value,
                style: TextStyle(fontSize: 18),
              )),
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
            fontSize: 16,
            color: context.resources.color.colorDarkest,
            // fontWeight: FontWeight.bold,
            fontFamily: 'primary',
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.check,
              color: context.resources.color.positive,
              size: 22,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0,
              horizontal: MediaQuery.of(context).size.width * 0.01,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: context.resources.color.colorDarkest),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: context.resources.color.colorDarkest),
            ),
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
        if (!mounted) return;
        SnackBarUtils.showCustomSnackBar(
          context: context,
          backgroundColor: context.resources.color.colorNormal3,
          content: "Your book moved to Completed shelf",
        );
      } else if (selectedValue == "Incomplete") {
        widget.bookStatus = false;
        if (!mounted) return;
        SnackBarUtils.showCustomSnackBar(
          context: context,
          backgroundColor: context.resources.color.colorNormal3,
          content: "Your book moved to Incomplete shelf",
        );
      }

      widget.libraryBookStatusUpdateCallback(widget.bookStatus);
    }
  }
}
