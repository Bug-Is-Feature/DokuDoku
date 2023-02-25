import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBookDialog {
  Widget inputField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Book $label',
        border: const OutlineInputBorder(),
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a book $label';
        } else {
          return null;
        }
      },
    );
  }

  Future<void> editBookPopup(
    BuildContext context,
    int id,
    int pageCount,
    double price,
    String title,
    String subtitle,
    String category,
    String thumbnail,
    String description,
    String currencyCode,
  ) async {
    final provider = Provider.of<BookProvider>(context, listen: false);

    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () async {
                await BookService.updateBook(context, id);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Custom book updated successfully'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
              ),
              child: const Text('Edit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
              ),
              child: const Text('No'),
            ),
          ],
          title: const Text('Edit Book'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField(
                        'title', provider.editTitleController..text = title),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('subtitle',
                        provider.editSubtitleController..text = subtitle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('category',
                        provider.editCategoryController..text = category),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('author',
                        provider.editAuthorController..text = 'author'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('description',
                        provider.editDescriptionController..text = description),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField(
                        'currency code',
                        provider.editCurrencyCodeController
                          ..text = currencyCode),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField(
                        'pages',
                        provider.editPageCountController
                          ..text = pageCount.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField(
                        'price',
                        provider.editBookPriceController
                          ..text = price.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('picture',
                        provider.editThumbnailController..text = thumbnail),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
