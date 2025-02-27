

import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/cart/domain/entities/cart_product.dart';
import 'package:hero_market/src/cart/domain/repos/cart_repo.dart';

class GetCart extends UsecasesWithParams<List<CartProduct>, String> {
  const GetCart(this._repo);

  final CartRepo _repo;

  @override
  ResultFuture<List<CartProduct>> call(String params) => _repo.getCart(params);
}
