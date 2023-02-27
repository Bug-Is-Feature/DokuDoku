import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:dokudoku/ui/view/search_google_book_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/ui/components/add_book_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

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
  String? scanResult;

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
                removeCallback: widget.removeCallback,
                isbn: '',
              ),
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
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          String error = '';
                          LibraryBooks libraryBook =
                              await BookService.addCustomBook(context)
                                  .catchError((e) => error = e);
                          if (!mounted) return;
                          if (error.isEmpty) {
                            Provider.of<BookProvider>(context, listen: false)
                                .clearBookControllers();
                            Navigator.of(context).pop();
                            SnackBarUtils.showSuccessSnackBar(
                                context: context,
                                content: 'Added book successfully');
                            widget.addCallback(error.isEmpty, libraryBook);
                          } else {
                            SnackBarUtils.showWarningSnackBar(
                                context: context,
                                content: 'Something went wrong.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[400],
                        ),
                        child: const Text('Upload'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[400],
                        ),
                        child: const Text('No'),
                      ),
                    ],
                    title: const Text('Add Book'),
                    content: const AddBookDialog(),
                  );
                });
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
        addCallback: widget.addCallback,
        removeCallback: widget.removeCallback,
      ),
    ));
    print('scanResult: $scanResult');
  }
}
