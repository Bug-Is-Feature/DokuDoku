import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/author_card.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:dokudoku/ui/components/textfield_custombook.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddBookDialog extends StatefulWidget {
  final void Function(bool, LibraryBooks) libraryBookAddCallback;
  const AddBookDialog({
    super.key,
    required this.libraryBookAddCallback,
  });

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  List<String> authorList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context, listen: false);
    return AlertDialog(
        actions: [
          Button(
            child: Text('Upload'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
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
                      context: context, content: 'Added book successfully');
                  widget.libraryBookAddCallback(error.isEmpty, libraryBook);
                } else {
                  SnackBarUtils.showWarningSnackBar(
                      context: context, content: 'Something went wrong.');
                }
              }
            },
            backgroundColor: context.resources.color.colorDarkest,
            size: Size(84, 30),
          ),

          //   ElevatedButton(
          //     onPressed: () async {
          //       if (_formKey.currentState!.validate()) {
          //         String error = '';
          //         LibraryBooks libraryBook =
          //             await BookService.addCustomBook(context)
          //                 .catchError((e) => error = e);
          //         if (!mounted) return;
          //         if (error.isEmpty) {
          //           Provider.of<BookProvider>(context, listen: false)
          //               .clearBookControllers();
          //           Navigator.of(context).pop();
          //           SnackBarUtils.showSuccessSnackBar(
          //               context: context, content: 'Added book successfully');
          //           widget.addCallback(error.isEmpty, libraryBook);
          //         } else {
          //           SnackBarUtils.showWarningSnackBar(
          //               context: context, content: 'Something went wrong.');
          //         }
          //       }
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.brown[400],
          //     ),
          //     child: const Text('Upload'),
          //   ),

          Button(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context, false);
              Provider.of<BookProvider>(context, listen: false)
                  .clearBookControllers();
            },
            backgroundColor: context.resources.color.colorDarkest,
            size: Size(82, 30),
          ),
          //   ElevatedButton(
          //     onPressed: () {
          //       Navigator.pop(context, false);
          //       Provider.of<BookProvider>(context, listen: false)
          //           .clearBookControllers();
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.brown[400],
          //     ),
          //     child: const Text('No'),
          //   ),
        ],
        title: Text(
          'Add Book',
          style: TextStyle(
              color: context.resources.color.colorDarkest,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              fontFamily: 'primary'),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: TextFieldCustomBook(
                    labelText: "Title",
                    maxLines: null,
                    label: "Title",
                    controller: provider.titleController,
                    keyboardType: TextInputType.text,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title ';
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
                    labelText: "Subtitle",
                    maxLines: null,
                    label: "Subtitle",
                    controller: provider.subtitleController,
                    keyboardType: TextInputType.text,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: TextFieldCustomBook(
                    labelText: "Category",
                    maxLines: null,
                    label: "Category",
                    controller: provider.categoryController,
                    keyboardType: TextInputType.text,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: TextFieldCustomBook(
                    labelText: "Author",
                    maxLines: null,
                    label: "Author",
                    controller: provider.authorController,
                    keyboardType: TextInputType.text,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: TextFieldCustomBook(
                    labelText: "Description",
                    maxLines: 4,
                    label: "Description",
                    controller: provider.descriptionController,
                    keyboardType: TextInputType.multiline,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.32,
                        child: TextFormField(
                          controller: provider.bookPriceController,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: false,
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                          ],
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Price",
                            contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04),
                            hintText: "Price",
                            hintStyle: TextStyle(
                                color: context.resources.color.greyDarker),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: context.resources.color.colorDarkest),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: context.resources.color.colorDarkest),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.32,
                        child: TextFormField(
                          controller: provider.currencyCodeController,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z]')),
                          ],
                          validator: (value) {
                            //   if (value.toString().length != 3) {
                            //     return 'Please enter a valid currency code';
                            //   } else if (value.isEmpty) {
                            //     return null;
                            //   }
                          },
                          decoration: InputDecoration(
                            labelText: "Currency code",
                            contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04),
                            hintText: "Currency code",
                            hintStyle: TextStyle(
                                color: context.resources.color.greyDarker),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: context.resources.color.colorDarkest),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: context.resources.color.colorDarkest),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 12,
                //   ),
                //   child: TextFieldCustomBook(
                //     maxLines: null,
                //     label: "currency code",
                //     controller: provider.currencyCodeController,
                //     keyboardType: TextInputType.text,
                //     inputFormatter:
                //         FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                //     validator: (value) {
                //       //   if (value.toString().length != 3) {
                //       //     return 'Please enter a valid currency code';
                //       //   } else if (value.isEmpty) {
                //       //     return null;
                //       //   }
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: TextFieldCustomBook(
                    labelText: "Pages",
                    maxLines: null,
                    label: "Pages",
                    controller: provider.pageCountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
                    inputFormatter: FilteringTextInputFormatter.digitsOnly,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a page count ';
                      } else if (int.parse(value) < 0) {
                        return 'Please enter a valid page count';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 12,
                //   ),
                //   child: TextFieldCustomBook(
                //     maxLines: null,
                //     label: "price",
                //     controller: provider.bookPriceController,
                //     keyboardType: const TextInputType.numberWithOptions(
                //       signed: false,
                //       decimal: true,
                //     ),
                //     inputFormatter:
                //         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                //     validator: (value) {
                //       return null;
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: TextFieldCustomBook(
                    labelText: "Picture",
                    maxLines: null,
                    label: "Picture",
                    controller: provider.thumbnailController,
                    keyboardType: TextInputType.text,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    validator: (value) {
                      return null;
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
        ));
  }
}
