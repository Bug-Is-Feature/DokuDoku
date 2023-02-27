import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/author_card.dart';
import 'package:dokudoku/ui/components/textfield_custombook.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({super.key});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  List<String> authorList = [];
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
                controller: provider.titleController,
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
                controller: provider.subtitleController,
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
                controller: provider.categoryController,
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
                controller: provider.authorController,
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
                controller: provider.descriptionController,
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
                controller: provider.currencyCodeController,
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
                controller: provider.pageCountController,
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
                controller: provider.bookPriceController,
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
                controller: provider.thumbnailController,
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
