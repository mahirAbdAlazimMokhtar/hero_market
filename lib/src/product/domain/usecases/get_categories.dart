import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/src/product/domain/entities/category.dart';
import 'package:hero_market/src/product/domain/repositories/product_repo.dart';

import '../../../../core/utils/typedefs.dart';

class GetCategories  extends UsecasesWithoutParams<List<ProductCategory>> {
  final ProductRepo _productRepo;
  GetCategories(this._productRepo);
  @override
  ResultFuture<List<ProductCategory>> call() {
    return _productRepo.getCategories();
  }
}