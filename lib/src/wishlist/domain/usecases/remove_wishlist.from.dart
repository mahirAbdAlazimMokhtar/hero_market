import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/src/wishlist/domain/repository/wishlist_repo.dart';

import '../../../../core/utils/typedefs.dart';

class RemoveFromWishlist
    extends UsecasesWithParams<void, RemoveFromWishlistParams> {
  const RemoveFromWishlist(this._repo);

  final WishlistRepo _repo;

  @override
  ResultFuture<void> call(RemoveFromWishlistParams params) =>
      _repo.removeFromWishlist(
        userId: params.userId,
        productId: params.productId,
      );
}

class RemoveFromWishlistParams extends Equatable {
  const RemoveFromWishlistParams({
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