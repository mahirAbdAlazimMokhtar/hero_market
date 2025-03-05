part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class FetchingProducts extends ProductState {
  const FetchingProducts();
}
final class ProductLoading extends ProductState {
  const ProductLoading();
}
final class FetchingProduct extends ProductLoading {
  const FetchingProduct();
}

final class SearchingProduct extends ProductLoading {
  const SearchingProduct();
}

final class FetchingReviews extends ProductLoading {
  const FetchingReviews();
}

final class FetchingCategories extends ProductLoading {
  const FetchingCategories();
}

final class FetchingCategory extends ProductLoading {
  const FetchingCategory();
}

final class Reviewing extends ProductLoading {
  const Reviewing();
}

final class ProductsFetched extends ProductState {
  final List<Product> products;
  const ProductsFetched(this.products);

  @override
  List<Object> get props => products;
}

final class CategoriesFetched extends ProductState {
  final List<ProductCategory> categories;
  const CategoriesFetched(this.categories);

  @override
  List<Object> get props => categories;
}

final class ReviewsFetched extends ProductState {
  final List<Review> reviews;
  const ReviewsFetched(this.reviews);

  @override
  List<Object> get props =>  reviews;
}

final class ProductFetched extends ProductState {
  final Product product;
  const ProductFetched(this.product);

  @override
  List<Object> get props => [product];
}

final class CategoryFetched extends ProductState {
  final ProductCategory category;
  const CategoryFetched(this.category);
}
final class ProductReviewed extends ProductState {

  const ProductReviewed();
}

final class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
