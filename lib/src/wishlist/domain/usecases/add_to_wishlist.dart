import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/src/wishlist/domain/repository/wishlist_repo.dart';

import '../../../../core/utils/typedefs.dart';

class AddToWishlist extends UsecasesWithParams<void, AddToWishlistParams> {
  const AddToWishlist(this._repo);

  final WishlistRepo _repo;

  @override
  ResultFuture<void> call(AddToWishlistParams params) => _repo.addToWishlist(
        userId: params.userId,
        productId: params.productId,
      );
}

class AddToWishlistParams extends Equatable {
  const AddToWishlistParams({
    required this.userId,
    required this.productId,
  });

  final String userId;
  final String productId;

  @override
  List<dynamic> get props => [
        userId,
        productId,
      ];
}
