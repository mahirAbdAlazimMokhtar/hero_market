import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';
import 'package:hero_market/src/product/domain/repositories/product_repo.dart';

class GetNewArrivals
    extends UsecasesWithParams<List<Product>, GetNewArrivalsPrams> {
  final ProductRepo _productRepo;
  GetNewArrivals(this._productRepo);

  @override
  ResultFuture<List<Product>> call(GetNewArrivalsPrams params) {
    return _productRepo.getNewArrivals(
        page: params.page, categoryId: params.categoryId);
  }
}

class GetNewArrivalsPrams extends Equatable {
  final int page;
  final String? categoryId;

  const GetNewArrivalsPrams({required this.page, this.categoryId});

  @override
  List<Object?> get props => [page, categoryId];
}
