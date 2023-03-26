import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:flutter/material.dart';

class BookProvider extends ChangeNotifier {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final categoryController = TextEditingController();
  final thumbnailController = TextEditingController();
  final descriptionController = TextEditingController();
  final pageCountController = TextEditingController();
  final currencyCodeController = TextEditingController();
  final bookPriceController = TextEditingController();
  final authorController = TextEditingController();

  final editTitleController = TextEditingController();
  final editSubtitleController = TextEditingController();
  final editCategoryController = TextEditingController();
  final editThumbnailController = TextEditingController();
  final editDescriptionController = TextEditingController();
  final editPageCountController = TextEditingController();
  final editCurrencyCodeController = TextEditingController();
  final editBookPriceController = TextEditingController();
  final editAuthorController = TextEditingController();

  late Future<Library> library = _getLibrary();
  Future<Library> _getLibrary() async {
    List<Library> library = await BookService.getLibrary();
    return library[0];
  }

  void clearBookControllers() {
    titleController.clear();
    subtitleController.clear();
    categoryController.clear();
    thumbnailController.clear();
    descriptionController.clear();
    pageCountController.clear();
    currencyCodeController.clear();
    bookPriceController.clear();
    authorController.clear();
  }
}
