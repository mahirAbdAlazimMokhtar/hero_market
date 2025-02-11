import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel(
      {required super.id,
      required super.comment,
      required super.userId,
      required super.userName,
      required super.rating,
      required super.date});

  ReviewModel copyWith({
    String? id,
    String? comment,
    String? userId,
    String? userName,
    double? rating,
    DateTime? date,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      rating: rating ?? this.rating,
      date: date ?? this.date,
    );
  }

  //create empty constructor
  ReviewModel.empty(DateTime? date)
      : this(
          id: 'Test String',
          comment: 'Test String',
          userId: 'Test String',
          userName: 'Test String',
          rating: 1,
          date: date ?? DateTime.now(),
        );

  //create toMap method

  //create fromMap and toMap methods
  ReviewModel.fromMap(DataMap map)
      : this(
          id: map['id'],
          comment: map['comment'],
          userId: map['userId'],
          userName: map['userName'],
          rating: map['rating'],
          date: map['date'],
        );

  DataMap toMap() {
    return {
      'id': id,
      'comment': comment,
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'date': date,
    };
  }
}
