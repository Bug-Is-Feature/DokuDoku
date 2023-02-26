import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/services/book_service.dart';
import 'package:dokudoku/ui/components/add_book_dialog.dart';
import 'package:dokudoku/ui/view/book_detail_view.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BookShelfView extends StatefulWidget {
  const BookShelfView({Key? key}) : super(key: key);

  @override
  State<BookShelfView> createState() => _BookShelfViewState();
}

class _BookShelfViewState extends State<BookShelfView> {
  late Future<Library> library = _getLibrary();
  AddBookDialog addBookDialog = AddBookDialog();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // refreshBooks();
  }

//   Future refreshBooks() async {
//     setState(() => isLoading = true);
//     setState(() => isLoading = false);
//   }

  Future<Library> _getLibrary() async {
    List<Library> library = await BookService.getLibrary();
    return library[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: const Center(
          child: Text('Bookshelf'),
        ),
        backgroundColor: Colors.brown[400],
        actions: [
          IconButton(
            onPressed: () async {
              await addBookDialog.addBookPopup(context);
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FutureBuilder<Library>(
              future: _getLibrary(),
              builder: (BuildContext context, AsyncSnapshot<Library> snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : snapshot.data?.libraryBooks.isEmpty ?? true
                        ? const EmptyBookshelfWidget()
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data?.libraryBooks.length,
                            itemBuilder: (context, index) {
                              final libraryBook =
                                  snapshot.data?.libraryBooks[index];
                              return Card(
                                child: ListTile(
                                  leading: Image.network(
                                    libraryBook?.book.thumbnail ?? '',
                                    height: 200,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: ((context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            'assets/images/default_book_cover.png')),
                                  ),
                                  title: Text(libraryBook?.book.title ?? ''),
                                  subtitle: Row(
                                    children: [
                                      if (libraryBook!
                                          .book.authors.isEmpty) ...[
                                        const Text('No author details')
                                      ] else ...[
                                        Text(
                                            'by ${libraryBook.book.authors.map((author) => author.name).join(', ')}'),
                                      ],
                                      const SizedBox(width: 5),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeView(
                                                    //   id: libraryBook.book.id,
                                                    //   title: libraryBook
                                                    //       .book.title,
                                                    )),
                                          );
                                        },
                                        icon: const Icon(Icons.timer),
                                      ),
                                    ],
                                  ),
                                  onLongPress: () async {
                                    await BookService.removeBookById(
                                        libraryBook.libraryBookId);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('removed book successfully'),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  onTap: () async {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => BookDetailView(
                                    //             id: libraryBook.book.id,
                                    //             title: libraryBook.book.title,
                                    //             subtitle:
                                    //                 libraryBook.book.subtitle,
                                    //             category:
                                    //                 libraryBook.book.category,
                                    //             thumbnail:
                                    //                 libraryBook.book.thumbnail,
                                    //             description: libraryBook
                                    //                 .book.description,
                                    //             pageCount:
                                    //                 libraryBook.book.pageCount,
                                    //             currencyCode: libraryBook
                                    //                 .book.currencyCode,
                                    //             price: libraryBook.book.price,
                                    //             googleBookId: libraryBook
                                    //                 .book.googleBookId,
                                    //             author:
                                    //                 libraryBook.book.authors,
                                    //             isCompleted:
                                    //                 libraryBook.isCompleted,
                                    //           )),
                                    // );
                                  },
                                ),
                              );
                            },
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyBookshelfWidget extends StatelessWidget {
  const EmptyBookshelfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Click ",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            WidgetSpan(
              child: Icon(
                Icons.bookmark_border,
                size: 18,
              ),
            ),
            TextSpan(
              text: " to add books to the bookshelf",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
