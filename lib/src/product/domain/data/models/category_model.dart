import '../../entities/category.dart';

class ProductCategoryModel extends ProductCategory {
  const ProductCategoryModel({
    required super.id,
    super.name,
    super.color,
    super.image,
  });
  const ProductCategoryModel.empty() : super(id: 'Test String');

  factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
    return ProductCategoryModel(
      id: map['id'] as String,
      name: map['name'] as String?,
      color: map['color'] as String?,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'image': image,
    };
  }

  ProductCategory copyWith({
    String? id,
    String? name,
    String? color,
    String? image,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      image: image ?? this.image,
    );
  }
}
