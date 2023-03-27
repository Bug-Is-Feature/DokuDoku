import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:dokudoku/ui/components/textfield_custombook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AddBookView extends StatefulWidget {
  final void Function(bool, LibraryBooks) libraryBookAddCallback;
  const AddBookView({
    super.key,
    required this.libraryBookAddCallback,
  });

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  List<String> authorList = [];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(34),
        child: AppBar(
          foregroundColor: context.resources.color.colorDarkest,
          centerTitle: true,
          title: Text(
            "Add Book",
            style: TextStyle(
                fontFamily: 'primary',
                color: context.resources.color.colorDarkest,
                fontSize: 28),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 50),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.36,
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
                            filled: true,
                            fillColor: context.resources.color.colorWhite,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.36,
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
                            filled: true,
                            fillColor: context.resources.color.colorWhite,
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
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                  context: context,
                                  content: 'Added book successfully');
                              widget.libraryBookAddCallback(
                                  error.isEmpty, libraryBook);
                            } else {
                              SnackBarUtils.showWarningSnackBar(
                                  context: context,
                                  content: 'Something went wrong.');
                            }
                          }
                        },
                        backgroundColor: context.resources.color.colorDark,
                        size: Size(84, 30),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Button(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.pop(context, false);
                          Provider.of<BookProvider>(context, listen: false)
                              .clearBookControllers();
                        },
                        backgroundColor: context.resources.color.colorDark,
                        size: Size(82, 30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
