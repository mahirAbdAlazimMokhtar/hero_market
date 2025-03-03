import 'dart:convert';

import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/wishlist_product.dart';


class WishlistProductModel extends WishlistProduct {
  const WishlistProductModel({
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.productExists,
    required super.productOutOfStock,
    required super.productPrice,
  });
  WishlistProductModel copyWith({
    String? productId,
    String? productName,
    String? productImage,
    double? productPrice,
    bool? productExists,
    bool? productOutOfStock,
  }) {
    return WishlistProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      productExists: productExists ?? this.productExists,
      productOutOfStock: productOutOfStock ?? this.productOutOfStock,
    );
  }

  const WishlistProductModel.empty()
      : this(
          productId: "Test String",
          productName: "Test String",
          productImage: "Test String",
          productPrice: 1.0,
          productExists: true,
          productOutOfStock: true,
        );

  WishlistProductModel.fromMap(DataMap map)
      : this(
          productId: map['productId'] as String? ?? '',
          productName: map['productName'] as String? ?? '',
          productImage: map['productImage'] as String? ?? '',
          productPrice: (map['productPrice'] != null) 
              ? (map['productPrice'] as num).toDouble() 
              : 0.0,
          productExists: map['productExists'] as bool? ?? true,
          productOutOfStock: map['productOutOfStock'] as bool? ?? false,
        );

  DataMap toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productExists': productExists,
      'productOutOfStock': productOutOfStock,
    };
  }

  factory WishlistProductModel.fromJson(String source) =>
      WishlistProductModel.fromMap(jsonDecode(source) as DataMap);

  String toJson() => jsonEncode(toMap());
}
