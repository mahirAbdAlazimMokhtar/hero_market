import 'package:flutter/material.dart';
import 'package:hero_market/core/extensions/color_extension.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/data/models/category_model.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.id,
      required super.name,
      required super.image,
      required super.description,
      required super.price,
      required super.category,
      required super.rating,
      required super.colors,
      required super.images,
      required super.sizes,
      required super.reviewIds,
      required super.countInStock,
      required super.numOfReviews,
      super.genderAgeCategory});

  ProductModel copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    double? price,
    ProductCategoryModel? category,
    double? rating,
    List<Color>? colors,
    List<String>? images,
    List<String>? sizes,
    List<String>? reviewIds,
    String? genderAgeCategory,
    int? countInStock,
    int? numOfReviews,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      colors: colors ?? this.colors,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      reviewIds: reviewIds ?? this.reviewIds,
      countInStock: countInStock ?? this.countInStock,
      numOfReviews: numOfReviews ?? this.numOfReviews,
      genderAgeCategory: genderAgeCategory ?? this.genderAgeCategory,
    );
  }

  const ProductModel.empty()
      : this(
            id: '',
            name: '',
            image: '',
            description: '',
            price: 1,
            category: const ProductCategoryModel.empty(),
            rating: 1,
            colors: const [],
            images: const [],
            sizes: const [],
            reviewIds: const [],
            countInStock: 1,
            numOfReviews: 1,
            genderAgeCategory: '12');
  //create toMap and fromMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'category': category,
      'rating': rating,
      'colors': colors.map((color) => color.hex).toList(),
      'images': images,
      'sizes': sizes,
      'reviewIds': reviewIds,
      'countInStock': countInStock,
      'numOfReviews': numOfReviews,
      'genderAgeCategory': genderAgeCategory,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final colors = map['colors'] as List<dynamic>?;
    final images = map['images'] as List<dynamic>?;
    final sizes = map['sizes'] as List<dynamic>?;
    final reviewIds = map['reviewIds'] as List<dynamic>?;
    final category = map['category'];
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      category: category is String
          ? ProductCategoryModel(id: category)
          : ProductCategoryModel.fromMap(category as DataMap),
      rating: (map['rating'] as num).toDouble(),
      colors: colors == null
          ? []
          : List<String>.from(colors).map((hex) => hex.colors).toList(),
      images: images == null ? [] : List<String>.from(images),
      sizes: sizes == null ? [] : List<String>.from(sizes),
      reviewIds: reviewIds == null ? [] : List<String>.from(reviewIds),
      countInStock: (map['countInStock'] as num).toInt(),
      numOfReviews: (map['numOfReviews'] as num).toInt(),
      genderAgeCategory: map['genderAgeCategory'] as String,
    );
  }
}
