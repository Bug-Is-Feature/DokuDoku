import 'dart:convert';

import 'package:dokudoku/model/author.dart';
import 'package:dokudoku/model/user.dart';

class Book {
  final int id;
  final String title,
      subtitle,
      category,
      thumbnail,
      description,
      currencyCode,
      googleBookId,
      createAt;
  final double price;
  final int pageCount;
  final List<Author> authors;
  final Users createdBy;

  const Book({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.thumbnail,
    required this.description,
    required this.currencyCode,
    required this.price,
    required this.pageCount,
    required this.authors,
    required this.googleBookId,
    required this.createAt,
    required this.createdBy,
  });

  factory Book.fromJson(json) {
    return Book(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      category: json['category'],
      thumbnail: json['thumbnail'] ?? '',
      description: json['description'],
      pageCount: json['page_count'] ?? -1,
      currencyCode: json['currency_code'] ?? '',
      price: json['price'] ?? -1,
      createdBy: Users.fromJson(json['created_by'] ?? {}),
      googleBookId: json['google_book_id'] ?? '',
      authors: json['authors'] != null
          ? List<Author>.from(json['authors']
              .map((authorsData) => Author.fromJson(authorsData))
              .toList())
          : [],
      createAt: json['create_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'category': category,
        'thumbnail': thumbnail,
        'description': description,
        'page_count': pageCount,
        'currency_code': currencyCode,
        'price': price,
        'uid': createdBy.uid,
        'google_book_id': googleBookId,
        'authors': authors.map((author) => author.toJson()).toList(),
      };
}
