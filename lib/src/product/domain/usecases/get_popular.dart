import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';

import '../../../../core/utils/typedefs.dart';
import '../entities/product.dart';
import '../repositories/product_repo.dart';

class GetPopular extends UsecasesWithParams<List<Product>, GetPopularParams> {
  const GetPopular(this._repo);

  final ProductRepo _repo;

  @override
  ResultFuture<List<Product>> call(GetPopularParams params) => _repo.getPopular(
        page: params.page,
        categoryId: params.categoryId,
      );
}

class GetPopularParams extends Equatable {
  const GetPopularParams({
    required this.page,
    this.categoryId,
  });

  final int page;
  final String? categoryId;

  @override
  List<Object?> get props => [page, categoryId];
}