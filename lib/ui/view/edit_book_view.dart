import 'package:currency_picker/currency_picker.dart';
import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/services/storage_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/edit_image_upload_widget.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:dokudoku/ui/components/textfield_custombook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditBookView extends StatefulWidget {
  final LibraryBooks libraryBook;
  final void Function(bool, Book) bookUpdateCallback;
  const EditBookView(
      {super.key, required this.libraryBook, required this.bookUpdateCallback});

  @override
  State<EditBookView> createState() => _EditBookViewState();
}

class _EditBookViewState extends State<EditBookView> {
  final _formKey = GlobalKey<FormState>();
  String imagePath = '';
  bool isUploadFailed = false;
  String _selectedCurrency = 'THB';

  @override
  void initState() {
    super.initState();
    _selectedCurrency = widget.libraryBook.book.currencyCode;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context, listen: false);
    final StorageService storage = StorageService();
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(34),
        child: AppBar(
          foregroundColor: context.resources.color.colorDark,
          centerTitle: true,
          title: Text(
            "Edit Book",
            style: TextStyle(
              fontFamily: 'primary',
              fontWeight: FontWeight.bold,
              color: context.resources.color.colorDarkest,
              fontSize: 28,
            ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Book Information',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: TextFieldCustomBook(
                    labelText: "Title",
                    maxLines: null,
                    label: "Title",
                    controller: provider.editTitleController
                      ..text = widget.libraryBook.book.title,
                    keyboardType: TextInputType.text,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
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
                    controller: provider.editSubtitleController
                      ..text = widget.libraryBook.book.subtitle,
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
                    controller: provider.editCategoryController
                      ..text = widget.libraryBook.book.category,
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
                    controller: provider.editAuthorController..text = 'Author',
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
                    controller: provider.editDescriptionController
                      ..text = widget.libraryBook.book.description,
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
                      ElevatedButton(
                        onPressed: () => showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showSearchField: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          onSelect: (Currency currency) {
                            setState(() => _selectedCurrency = currency.code);
                          },
                          favorite: ['THB'],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.resources.color.colorDarkest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_selectedCurrency),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: TextFormField(
                          controller: provider.editBookPriceController
                            ..text = widget.libraryBook.book.price.toString(),
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: false,
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                          ],
                          validator: (value) {
                            if (double.parse(value!) < 0) {
                              return 'Please enter a valid price';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Price",
                            filled: true,
                            fillColor: context.resources.color.colorWhite,
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
                    controller: provider.editPageCountController
                      ..text = widget.libraryBook.book.pageCount.toString(),
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
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Page Cover',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldCustomBook(
                  labelText: "Image URL",
                  maxLines: null,
                  label: "Image URL",
                  controller: provider.editThumbnailController
                    ..text = widget.libraryBook.book.thumbnail == ''
                        ? ''
                        : widget.libraryBook.book.thumbnail.substring(0, 5) ==
                                'url::'
                            ? widget.libraryBook.book.thumbnail
                                .replaceFirst('url::', '')
                            : '',
                  keyboardType: TextInputType.text,
                  inputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  validator: (value) {
                    if (value.toString().isNotEmpty && imagePath.isNotEmpty) {
                      return 'Only one field is available between url and upload.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xff92603D),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'or upload from device',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xff92603D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                EditImageUploadWidget(
                  libraryBook: widget.libraryBook,
                  imageCallback: (String path) {
                    setState(() => imagePath = path);
                  },
                  //   imageProviderCallback: (ImageProvider imageProvider) {
                  //     setState(() => imageProvider = imageProvider);
                  //   },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        child: const Text('Edit'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String apiError = '';
                            String storagePath = '';
                            String imageError = '';

                            provider.editCurrencyCodeController.text =
                                _selectedCurrency;
                            if (imagePath.isNotEmpty) {
                              await storage
                                  .uploadFile(filePath: imagePath)
                                  .then((ref) => storagePath = ref)
                                  .catchError((e) => imageError = e.toString());
                              if (imageError.isNotEmpty) {
                                setState(() {
                                  imagePath = '';
                                });
                                if (!mounted) return;
                                SnackBarUtils.showWarningSnackBar(
                                    context: context,
                                    content:
                                        'Edit unsuccessfully, please try again.');
                              }
                            }
                            if (imageError.isEmpty) {
                              if (!mounted) return;
                              Book editedBook = await BookService.updateBook(
                                      context,
                                      widget.libraryBook.book.id,
                                      storagePath)
                                  .catchError((e) => apiError = e);
                              if (!mounted) return;
                              if (apiError.isEmpty) {
                                Provider.of<BookProvider>(context,
                                        listen: false)
                                    .clearBookControllers();
                                Navigator.of(context).pop();
                                SnackBarUtils.showSuccessSnackBar(
                                    context: context,
                                    content: 'Updated book successfully');
                                widget.bookUpdateCallback(
                                    apiError.isEmpty, editedBook);
                              } else {
                                SnackBarUtils.showWarningSnackBar(
                                    context: context,
                                    content: 'Something went wrong.');
                              }
                            }
                          }
                        },
                        backgroundColor: context.resources.color.colorDarkest,
                        size: const Size(84, 30),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Button(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.pop(context, false);
                          Provider.of<BookProvider>(context, listen: false)
                              .clearBookControllers();
                        },
                        backgroundColor: context.resources.color.colorDarkest,
                        size: const Size(82, 30),
                      )
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
