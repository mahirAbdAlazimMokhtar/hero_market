

import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/cart/domain/repos/cart_repo.dart';

class GetCartCount extends UsecasesWithParams<int, String> {
  const GetCartCount(this._repo);

  final CartRepo _repo;

  @override
  ResultFuture<int> call(String params) => _repo.getCartCount(params);
}
