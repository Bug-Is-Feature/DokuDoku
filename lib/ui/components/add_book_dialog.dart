import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookDialog {
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

  Future<void> addBookPopup(BuildContext context) async {
    final provider = Provider.of<BookProvider>(context, listen: false);

    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () async {
                await BookService.addCustomBook(context);
                Provider.of<BookProvider>(context, listen: false)
                    .clearBookControllers();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Custom book added successfully'),
                  ),
                );
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
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('title', provider.titleController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('subtitle', provider.subtitleController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('category', provider.categoryController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('author', provider.authorController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField(
                        'description', provider.descriptionController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField(
                        'currency code', provider.currencyCodeController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('pages', provider.pageCountController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('price', provider.bookPriceController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('picture', provider.thumbnailController),
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
