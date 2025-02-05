import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/repositories/product_repo.dart';

class LeaveReview extends UsecasesWithParams<bool, LeaveReviewParams> {
  final ProductRepo _productRepo;
  LeaveReview(this._productRepo);

  @override
  ResultFuture<bool> call(LeaveReviewParams params) {
    return _productRepo.leaveReview(
      productId: params.productId,
      comment: params.comment,
      userId: params.userId,
      rating: double.parse(params.rating),
    );
  }
}

class LeaveReviewParams extends Equatable {
  final String productId;
  final String comment;
  final String rating;
  final String userId;

  const LeaveReviewParams({
    required this.productId,
    required this.comment,
    required this.rating,
    required this.userId,
  });

  @override
  List<Object> get props => [productId, comment, rating, userId];
}
