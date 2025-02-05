import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/entities/category.dart';

import '../repositories/product_repo.dart';

class GetCategory
    extends UsecasesWithParams<ProductCategory, GetCategoryParams> {
  final ProductRepo _productRepo;
  GetCategory(this._productRepo);

  @override
  ResultFuture<ProductCategory> call(GetCategoryParams params) {
    return _productRepo.getCategory(params.categoryId);
  }
}

class GetCategoryParams extends Equatable {
  final String categoryId;
  const GetCategoryParams(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
