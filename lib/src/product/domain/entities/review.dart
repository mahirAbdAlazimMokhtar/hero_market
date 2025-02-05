import 'package:equatable/equatable.dart';

class Review extends Equatable {
  const Review(
      {required this.id,
      required this.comment,
      required this.userId,
      required this.userName,
      required this.rating,
      required this.date});

  Review.empty()
      : id = 'Test String',
        comment = 'Test String',
        userId = 'Test String',
        userName = 'Test String',
        rating = 1,
        date = DateTime.now();
  final String id;
  final String comment;
  final String userId;
  final String userName;
  final double rating;
  final DateTime date;

  @override
  List<Object?> get props => [
        id,
        comment,
        userId,
        userName,
        rating,
        date,
      ];
}
