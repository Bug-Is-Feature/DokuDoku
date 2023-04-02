// import 'package:dokudoku/model/book.dart';
// import 'package:dokudoku/model/library_books.dart';
// import 'package:dokudoku/provider/book_provider.dart';
// import 'package:dokudoku/res/AppContextExtension.dart';
// import 'package:dokudoku/services/book_service.dart';
// import 'package:dokudoku/ui/components/button.dart';
// import 'package:dokudoku/ui/components/snack_bar_utils.dart';
// import 'package:dokudoku/ui/components/textfield_custombook.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class EditBookDialog extends StatefulWidget {
//   final LibraryBooks libraryBook;
//   final void Function(bool, Book) bookUpdateCallback;
//   const EditBookDialog({
//     super.key,
//     required this.libraryBook,
//     required this.bookUpdateCallback,
//   });

//   @override
//   State<EditBookDialog> createState() => _EditBookDialogState();
// }

// class _EditBookDialogState extends State<EditBookDialog> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<BookProvider>(context, listen: false);
//     return AlertDialog(
//       actions: [
//         Button(
//           child: Text('Edit'),
//           onPressed: () async {
//             if (_formKey.currentState!.validate()) {
//               String error = '';
//               Book editedBook = await BookService.updateBook(
//                       context, widget.libraryBook.book.id)
//                   .catchError((e) => error = e);

//               if (!mounted) return;
//               Navigator.of(context).pop();

//               if (error.isEmpty) {
//                 SnackBarUtils.showSuccessSnackBar(
//                     context: context, content: 'Updated book successfully');
//                 widget.bookUpdateCallback(error.isEmpty, editedBook);
//               } else {
//                 SnackBarUtils.showWarningSnackBar(
//                     context: context, content: 'Something went wrong');
//               }
//             }
//           },
//           backgroundColor: context.resources.color.colorDarkest,
//           size: Size(82, 30),
//         ),
//         // ElevatedButton(
//         //   onPressed: () async {
//         //     if (_formKey.currentState!.validate()) {
//         //       String error = '';
//         //       Book editedBook = await BookService.updateBook(
//         //               context, widget.libraryBook.book.id)
//         //           .catchError((e) => error = e);

//         //       if (!mounted) return;
//         //       Navigator.of(context).pop();

//         //       if (error.isEmpty) {
//         //         SnackBarUtils.showSuccessSnackBar(
//         //             context: context, content: 'Updated book successfully');
//         //         widget.bookUpdateCallback(error.isEmpty, editedBook);
//         //       } else {
//         //         SnackBarUtils.showWarningSnackBar(
//         //             context: context, content: 'Something went wrong');
//         //       }
//         //     }
//         //   },
//         //   style: ElevatedButton.styleFrom(
//         //     backgroundColor: Colors.brown[400],
//         //   ),
//         //   child: const Text('Edit'),
//         // ),
//         Button(
//           child: Text('No'),
//           onPressed: () {
//             Navigator.pop(context, false);
//           },
//           backgroundColor: context.resources.color.colorDarkest,
//           size: Size(82, 30),
//         )
//         // ElevatedButton(
//         //   onPressed: () {
//         //     Navigator.pop(context, false);
//         //   },
//         //   style: ElevatedButton.styleFrom(
//         //     backgroundColor: Colors.brown[400],
//         //   ),
//         //   child: const Text('No'),
//         // ),
//       ],
//       title: Text(
//         'Edit Book',
//         style: TextStyle(color: context.resources.color.colorDarkest),
//       ),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 12,
//                 ),
//                 child: TextFieldCustomBook(
//                   labelText: "Title",
//                   maxLines: null,
//                   label: "Title",
//                   controller: provider.editTitleController
//                     ..text = widget.libraryBook.book.title,
//                   keyboardType: TextInputType.text,
//                   inputFormatter:
//                       FilteringTextInputFormatter.singleLineFormatter,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a title';
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 12,
//                 ),
//                 child: TextFieldCustomBook(
//                   labelText: "Subtitle",
//                   maxLines: null,
//                   label: "Subtitle",
//                   controller: provider.editSubtitleController
//                     ..text = widget.libraryBook.book.subtitle,
//                   keyboardType: TextInputType.text,
//                   inputFormatter:
//                       FilteringTextInputFormatter.singleLineFormatter,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 12,
//                 ),
//                 child: TextFieldCustomBook(
//                   labelText: "Category",
//                   maxLines: null,
//                   label: "Category",
//                   controller: provider.editCategoryController
//                     ..text = widget.libraryBook.book.category,
//                   keyboardType: TextInputType.text,
//                   inputFormatter:
//                       FilteringTextInputFormatter.singleLineFormatter,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 12,
//                 ),
//                 child: TextFieldCustomBook(
//                   labelText: "Author",
//                   maxLines: null,
//                   label: "Author",
//                   controller: provider.editAuthorController..text = 'Author',
//                   keyboardType: TextInputType.text,
//                   inputFormatter:
//                       FilteringTextInputFormatter.singleLineFormatter,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 12,
//                 ),
//                 child: TextFieldCustomBook(
//                   labelText: "Description",
//                   maxLines: 4,
//                   label: "Description",
//                   controller: provider.editDescriptionController
//                     ..text = widget.libraryBook.book.description,
//                   keyboardType: TextInputType.multiline,
//                   inputFormatter:
//                       FilteringTextInputFormatter.singleLineFormatter,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 12,
//                 ),
//                 child: TextFieldCustomBook(
//                   labelText: "Pages",
//                   maxLines: null,
//                   label: "Pages",
//                   controller: provider.editPageCountController
//                     ..text = widget.libraryBook.book.pageCount.toString(),
//                   keyboardType: const TextInputType.numberWithOptions(
//                     signed: false,
//                     decimal: false,
//                   ),
//                   inputFormatter: FilteringTextInputFormatter.digitsOnly,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a page count ';
//                     } else if (int.parse(value) < 0) {
//                       return 'Please enter a valid page count';
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//               ),
//               //   Padding(
//               //     padding: const EdgeInsets.only(
//               //       top: 12,
//               //     ),
//               //     child: TextFieldCustomBook(
//               //       maxLines: null,
//               //       label: "currency code",
//               //       controller: provider.editCurrencyCodeController
//               //         ..text = widget.libraryBook.book.currencyCode,
//               //       keyboardType: TextInputType.text,
//               //       inputFormatter:
//               //           FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
//               //       validator: (value) {
//               //           if (value == null || value.isEmpty) {
//               //             return 'Please enter a book';
//               //           } else {
//               //             return null;
//               //           }
//               //       },
//               //     ),
//               //   ),
//               //   Padding(
//               //     padding: const EdgeInsets.only(
//               //       top: 12,
//               //     ),
//               //     child: TextFieldCustomBook(
//               //       maxLines: null,
//               //       label: "price",
//               //       controller: provider.editBookPriceController
//               //         ..text = widget.libraryBook.book.price.toString(),
//               //       keyboardType: const TextInputType.numberWithOptions(
//               //         signed: false,
//               //         decimal: true,
//               //       ),
//               //       inputFormatter:
//               //           FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
//               //       validator: (value) {
//               //         if (double.parse(value) < 0) {
//               //           return 'Please enter a valid price';
//               //         } else {
//               //           return null;
//               //         }
//               //       },
//               //     ),
//               //   ),

//               Padding(
//                 padding: const EdgeInsets.only(top: 12),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.32,
//                       child: TextFormField(
//                         controller: provider.editBookPriceController
//                           ..text = widget.libraryBook.book.price.toString(),
//                         keyboardType: const TextInputType.numberWithOptions(
//                           signed: false,
//                           decimal: true,
//                         ),
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
//                         ],
//                         validator: (value) {
//                           if (double.parse(value!) < 0) {
//                             return 'Please enter a valid price';
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Price",
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical:
//                                   MediaQuery.of(context).size.height * 0.01,
//                               horizontal:
//                                   MediaQuery.of(context).size.width * 0.04),
//                           hintText: "Price",
//                           hintStyle: TextStyle(
//                               color: context.resources.color.greyDarker),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: BorderSide(
//                                 color: context.resources.color.colorDarkest),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: BorderSide(
//                                 color: context.resources.color.colorDarkest),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.32,
//                       child: TextFormField(
//                         controller: provider.editCurrencyCodeController
//                           ..text = widget.libraryBook.book.currencyCode,
//                         keyboardType: TextInputType.text,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(
//                               RegExp(r'[a-zA-Z]')),
//                         ],
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a book';
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Currency code",
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical:
//                                   MediaQuery.of(context).size.height * 0.01,
//                               horizontal:
//                                   MediaQuery.of(context).size.width * 0.04),
//                           hintText: "Currency code",
//                           hintStyle: TextStyle(
//                               color: context.resources.color.greyDarker),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: BorderSide(
//                                 color: context.resources.color.colorDarkest),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: BorderSide(
//                                 color: context.resources.color.colorDarkest),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 12,
//                 ),
//                 child: TextFieldCustomBook(
//                   labelText: "Picture",
//                   maxLines: null,
//                   label: "Picture",
//                   controller: provider.editThumbnailController
//                     ..text = widget.libraryBook.book.thumbnail,
//                   keyboardType: TextInputType.text,
//                   inputFormatter:
//                       FilteringTextInputFormatter.singleLineFormatter,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//               ),
//               // const SizedBox(height: 20),

//               // Padding(
//               //   padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //     children: [
//               //       Text(
//               //         "Author",
//               //         style: TextStyle(
//               //             color: context.resources.color.colorDark,
//               //             fontSize: 16,
//               //             fontWeight: FontWeight.w600),
//               //       ),
//               //       IconButton(
//               //         icon: const Icon(Icons.add),
//               //         color: context.resources.color.colorDark,
//               //         onPressed: () {
//               //           showDialog(
//               //             context: context,
//               //             builder: (context) => AlertDialog(
//               //               shape: RoundedRectangleBorder(
//               //                 borderRadius: BorderRadius.circular(20),
//               //               ),
//               //               content: TextFormField(
//               //                 controller: provider.authorController,
//               //                 decoration: const InputDecoration(
//               //                   labelText: 'Author name',
//               //                   border: OutlineInputBorder(
//               //                       borderRadius:
//               //                           BorderRadius.all(Radius.circular(20))),
//               //                 ),
//               //               ),
//               //               actions: [
//               //                 TextButton(
//               //                   onPressed: () async {
//               //                     authorList.add(provider.authorController.text);
//               //                     Navigator.of(context).pop();
//               //                   },
//               //                   child: Text('Add'),
//               //                 ),
//               //                 TextButton(
//               //                   onPressed: () {
//               //                     Navigator.of(context).pop();
//               //                   },
//               //                   child: Text('No'),
//               //                 ),
//               //               ],
//               //             ),
//               //           );
//               //         },
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//             // ListView.builder(
//             //   itemCount: authorList.length,
//             //   itemBuilder: (context, index) {
//             //     // print(authorList.length);
//             //     // print(index);
//             //     return AuthorCard(
//             //       authorName: authorList[index],
//             //     );
//             //   },
//             // ),
//           ),
//         ),
//         //   itemCount: authorList.length,
//         //   itemBuilder: (context, index) {
//         //     // print(authorList.length);
//         //     // print(index);
//         //     return AuthorCard(
//         //       authorName: authorList[index],
//         //     );
//         //   },
//       ),
//     );
//   }
// }
