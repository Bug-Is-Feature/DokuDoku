import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/view/search_google_book_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/ui/components/add_book_dialog.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class BookshelvesFloatingButton extends StatefulWidget {
  Future<Library> library;
  final void Function(bool, LibraryBooks) addCallback, removeCallback;

  BookshelvesFloatingButton({
    super.key,
    required this.library,
    required this.addCallback,
    required this.removeCallback,
  });

  @override
  State<BookshelvesFloatingButton> createState() =>
      _BookshelvesFloatingButtonState();
}

class _BookshelvesFloatingButtonState extends State<BookshelvesFloatingButton> {
  AddBookDialog addBookDialog = AddBookDialog();

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: context.resources.color.colorDarkest,
      icon: Icons.add,
      children: [
        SpeedDialChild(
          backgroundColor: context.resources.color.colorDark,
          child: Icon(Icons.search, color: context.resources.color.colorWhite),
          label: 'Search Book',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SearchGoogleBookView(
                  library: widget.library,
                  addCallback: widget.addCallback,
                  removeCallback: widget.removeCallback),
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
          onTap: () async {
            await addBookDialog.addBookPopup(context);
            setState(() {});
          },
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
    );
  }
}
