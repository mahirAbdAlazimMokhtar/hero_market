import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';

import '../entities/product.dart';
import '../repositories/product_repo.dart';

class GetProducts extends UsecasesWithParams<List<Product>, int>{
  const GetProducts(this._repo);
  final ProductRepo _repo;
  @override
  ResultFuture<List<Product>> call(int params) {
   return _repo.getProducts(params);
  }
}