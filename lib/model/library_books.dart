import 'package:dokudoku/model/book.dart';

class LibraryBooks {
  final int libraryBookId;
  bool isCompleted;
  final String cratedAt;
  Book book;

  LibraryBooks({
    required this.libraryBookId,
    required this.isCompleted,
    required this.cratedAt,
    required this.book,
  });

  factory LibraryBooks.fromJson(json) {
    return LibraryBooks(
      libraryBookId: json['library_book_id'],
      isCompleted: json['is_completed'],
      cratedAt: json['created_at'],
      book: Book.fromJson(json['book']),
    );
  }

  Map<String, dynamic> toJson() => {
        'book_data': book,
        'is_completed': isCompleted,
      };
}
