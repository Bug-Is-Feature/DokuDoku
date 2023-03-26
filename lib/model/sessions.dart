import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/user.dart';

class Session {
  final int id, duration;
  final Book book;
  final Users createdBy;
  final String createdAt;
  final String timerType;

  Session({
    required this.id,
    required this.duration,
    required this.book,
    required this.createdBy,
    required this.createdAt,
    required this.timerType,
  });

  factory Session.fromJson(json) => Session(
        id: json['id'],
        duration: json['duration'],
        book: Book.fromJson(json['book']),
        createdBy: Users.fromJson(json['created_by']),
        createdAt: json['created_at'],
        timerType: json['timer_type'],
      );

  Map<String, dynamic> toJson() => {
        'uid': createdBy.uid,
        'book_id': book.id,
        'duration': duration,
        'timer_type': timerType,
      };
}
