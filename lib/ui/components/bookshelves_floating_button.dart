import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/view/add_book_view.dart';
import 'package:dokudoku/ui/view/search_google_book_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class BookshelvesFloatingButton extends StatefulWidget {
  Future<Library> library;
  final void Function(bool, LibraryBooks) libraryBookAddCallback,
      libraryBookRemoveCallback;

  BookshelvesFloatingButton({
    super.key,
    required this.library,
    required this.libraryBookAddCallback,
    required this.libraryBookRemoveCallback,
  });

  @override
  State<BookshelvesFloatingButton> createState() =>
      _BookshelvesFloatingButtonState();
}

class _BookshelvesFloatingButtonState extends State<BookshelvesFloatingButton> {
  String? scanResult;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      elevation: 6,
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
                libraryBookAddCallback: widget.libraryBookAddCallback,
                libraryBookRemoveCallback: widget.libraryBookRemoveCallback,
                isbn: '',
              ),
            ));
          },
        ),
        SpeedDialChild(
          backgroundColor: context.resources.color.colorDark,
          child: Icon(
            CupertinoIcons.book_fill,
            color: context.resources.color.colorWhite,
          ),
          label: 'Custom Book',
          onTap: () async {
            // await showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AddBookDialog(
            //         libraryBookAddCallback: widget.libraryBookAddCallback,
            //       );
            //     });
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddBookView(
                libraryBookAddCallback: widget.libraryBookAddCallback,
              ),
            ));
            setState(() {});
          },
        ),
        SpeedDialChild(
          backgroundColor: context.resources.color.colorDark,
          child: Icon(
            CupertinoIcons.barcode_viewfinder,
            color: context.resources.color.colorWhite,
          ),
          label: 'Add Book by ISBN',
          onTap: () {
            scanIsbn();
          },
        ),
      ],
    );
  }

  Future scanIsbn() async {
    String scanResult;

    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      scanResult = 'Failed to get platform version';
    }
    if (!mounted) return;

    setState(() {
      this.scanResult = scanResult;
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchGoogleBookView(
        library: widget.library,
        isbn: scanResult,
        libraryBookAddCallback: widget.libraryBookAddCallback,
        libraryBookRemoveCallback: widget.libraryBookRemoveCallback,
      ),
    ));
    print('scanResult: $scanResult');
  }
}
