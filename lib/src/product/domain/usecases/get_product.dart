import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';

import '../entities/product.dart';
import '../repositories/product_repo.dart';

class GetProduct extends UsecasesWithParams<Product, GetProductParams> {
  final ProductRepo _productRepo;
  GetProduct(this._productRepo);

  @override
  ResultFuture<Product> call(GetProductParams params) {
    return _productRepo.getProduct(params.productId);
  }
}

class GetProductParams extends Equatable {
  final String productId;

  const GetProductParams({required this.productId});

  @override
  List<Object> get props => [productId];
}
