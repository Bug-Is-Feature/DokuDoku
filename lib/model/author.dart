import 'package:dokudoku/model/book.dart';

class Author {
  final int id;
  final String name;
  final Book? book;

  Author({
    required this.id,
    required this.name,
    this.book,
  });

  factory Author.fromJson(json) => Author(
        id: json['id'],
        name: json['name'] ?? 'No name',
      );

  Map<String, dynamic> toJson() => {
        'book_id': book?.id,
        'name': name,
      };
}
