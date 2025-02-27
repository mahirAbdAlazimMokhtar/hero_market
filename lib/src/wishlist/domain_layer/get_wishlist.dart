import 'package:hero_market/core/usecase/usecase.dart';

import '../../../core/utils/typedefs.dart';
import 'entities/wishlist_product.dart';
import 'repository/wishlist_repo.dart';

class GetWishlist extends UsecasesWithParams<List<WishlistProduct>, String> {
  const GetWishlist(this._repo);

  final WishlistRepo _repo;

  @override
  ResultFuture<List<WishlistProduct>> call(String params) =>
      _repo.getWishlist(params);
}
