import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/model/user.dart';

class Library {
  final int id, bookCount, completedCount, incompleteCount;
  final Users createdBy;
  final String createdAt;
  List<LibraryBooks> libraryBooks;

  Library({
    required this.id,
    required this.bookCount,
    required this.completedCount,
    required this.incompleteCount,
    required this.createdBy,
    required this.createdAt,
    required this.libraryBooks,
  });

  factory Library.fromJson(Map<String, dynamic> json) => Library(
        id: json['id'],
        createdBy: Users.fromJson(json['created_by'] ?? {}),
        createdAt: json['created_at'],
        bookCount: json['book_count'] ?? -1,
        completedCount: json['completed_count'] ?? -1,
        incompleteCount: json['incomplete_count'] ?? -1,
        libraryBooks: json['books'] != null
            ? List<LibraryBooks>.from(json['books']
                .map((libraryBooksData) =>
                    LibraryBooks.fromJson(libraryBooksData))
                .toList())
            : [],
      );

  Map<String, dynamic> toJson() => {
        'uid': createdBy.uid,
      };
}
