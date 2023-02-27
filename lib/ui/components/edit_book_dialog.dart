import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/textfield_custombook.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBookDialog extends StatefulWidget {
  final LibraryBooks libraryBook;
  const EditBookDialog({super.key, required this.libraryBook});

  @override
  State<EditBookDialog> createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "title",
                controller: provider.editTitleController
                  ..text = widget.libraryBook.book.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book ';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "Subtitle",
                controller: provider.editSubtitleController
                  ..text = widget.libraryBook.book.subtitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book ';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "category",
                controller: provider.editCategoryController
                  ..text = widget.libraryBook.book.category,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book ';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "Author",
                controller: provider.editAuthorController..text = 'Author',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book ';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "description",
                controller: provider.editDescriptionController
                  ..text = widget.libraryBook.book.description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book ';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "currency code",
                controller: provider.editCurrencyCodeController
                  ..text = widget.libraryBook.book.currencyCode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "pages",
                controller: provider.editPageCountController
                  ..text = widget.libraryBook.book.pageCount.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book ';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "price",
                controller: provider.editBookPriceController
                  ..text = widget.libraryBook.book.price.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book ';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
              ),
              child: TextFieldCustomBook(
                label: "picture",
                controller: provider.editThumbnailController
                  ..text = widget.libraryBook.book.thumbnail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book ';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            // const SizedBox(height: 20),

            // Padding(
            //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Author",
            //         style: TextStyle(
            //             color: context.resources.color.colorDark,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600),
            //       ),
            //       IconButton(
            //         icon: const Icon(Icons.add),
            //         color: context.resources.color.colorDark,
            //         onPressed: () {
            //           showDialog(
            //             context: context,
            //             builder: (context) => AlertDialog(
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(20),
            //               ),
            //               content: TextFormField(
            //                 controller: provider.authorController,
            //                 decoration: const InputDecoration(
            //                   labelText: 'Author name',
            //                   border: OutlineInputBorder(
            //                       borderRadius:
            //                           BorderRadius.all(Radius.circular(20))),
            //                 ),
            //               ),
            //               actions: [
            //                 TextButton(
            //                   onPressed: () async {
            //                     authorList.add(provider.authorController.text);
            //                     Navigator.of(context).pop();
            //                   },
            //                   child: Text('Add'),
            //                 ),
            //                 TextButton(
            //                   onPressed: () {
            //                     Navigator.of(context).pop();
            //                   },
            //                   child: Text('No'),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
          // ListView.builder(
          //   itemCount: authorList.length,
          //   itemBuilder: (context, index) {
          //     // print(authorList.length);
          //     // print(index);
          //     return AuthorCard(
          //       authorName: authorList[index],
          //     );
          //   },
          // ),
        ),
      ),
      //   itemCount: authorList.length,
      //   itemBuilder: (context, index) {
      //     // print(authorList.length);
      //     // print(index);
      //     return AuthorCard(
      //       authorName: authorList[index],
      //     );
      //   },
    );
  }
}
