import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_market/src/product/domain/entities/category.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  final ProductCategory category;
  final double rating;
  final List<Color> colors;
  final List<String> images;
  final List<String> sizes;
  final List<String> reviewIds;
  final String? genderAgeCategory;
  final int countInStock;
  final int numOfReviews;

  const Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.colors,
    required this.images,
    required this.sizes,
    required this.reviewIds,
    this.genderAgeCategory,
    required this.countInStock,
    required this.numOfReviews,
  });

  const Product.empty()
      : id = 'Test String ',
        name = 'Test String',
        image = 'Test String',
        description = 'Test String',
        price = 1,
        category = const ProductCategory.empty(),
        rating = 1,
        colors = const [],
        images = const [],
        sizes = const [],
        reviewIds = const [],
        genderAgeCategory = 'Test String',
        countInStock = 1,
        numOfReviews = 1;

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        description,
        price,
        category,
        rating,
        colors,
        images,
        sizes,
        reviewIds,
        genderAgeCategory,
        countInStock,
        numOfReviews
      ];
}
