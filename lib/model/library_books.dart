import 'package:dokudoku/model/book.dart';

class LibraryBooks {
  final int libraryBookId;
  final bool isCompleted;
  final String cratedAt;
  final Book book;

  LibraryBooks({
    required this.libraryBookId,
    required this.isCompleted,
    required this.cratedAt,
    required this.book,
  });

  factory LibraryBooks.fromJson(json) => LibraryBooks(
        libraryBookId: json['library_book_id'],
        isCompleted: json['is_completed'] == 1 ? true : false,
        cratedAt: json['created_at'],
        book: Book.fromJson(json['book']),
      );

  Map<String, dynamic> toJson() => {
        'book_data': book,
        'is_completed': isCompleted,
      };
}
