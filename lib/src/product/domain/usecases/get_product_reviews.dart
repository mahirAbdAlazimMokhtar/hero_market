import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/entities/review.dart';
import 'package:hero_market/src/product/domain/repositories/product_repo.dart';

class GetProductReviews
    extends UsecasesWithParams<List<Review>, GetProductReviewsParams> {
  GetProductReviews(this._productRepo);
  final ProductRepo _productRepo;

  @override
  ResultFuture<List<Review>> call(GetProductReviewsParams params) {
    return _productRepo.getProductReviews(
        productId: params.productId, page: params.page);
  }
}

class GetProductReviewsParams extends Equatable {
  final String productId;
  final int page;

  const GetProductReviewsParams({required this.productId, required this.page});

  @override
  List<Object?> get props => [productId, page];
}
