import 'dart:convert';
import 'dart:ui';

import 'package:hero_market/core/extensions/color_extension.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/cart/domain/entities/cart_product.dart';



class CartProductModel extends CartProduct {
  const CartProductModel({
    required super.id,
    required super.productId,
    required super.quantity,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.productExists,
    required super.productOutOfStock,
    super.selectedSize,
    super.selectedColor,
  });

  const CartProductModel.empty()
      : this(
          id: "Test String",
          productId: "Test String",
          quantity: 1,
          productName: "Test String",
          productImage: "Test String",
          productPrice: 1,
          selectedSize: null,
          selectedColor: null,
          productExists: true,
          productOutOfStock: true,
        );

  factory CartProductModel.fromJson(String source) =>
      CartProductModel.fromMap(jsonDecode(source) as DataMap);

  CartProductModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String? ?? map['_id'] as String,
          productId: map['product'] as String,
          quantity: (map['quantity'] as num).toInt(),
          productName: map['productName'] as String,
          productImage: map['productImage'] as String,
          productPrice: (map['productPrice'] as num).toDouble(),
          selectedSize: map['selectedSize'] as String?,
          selectedColor: (map['selectedColor'] as String?)?.colors,
          productExists: map['productExists'] as bool? ?? true,
          productOutOfStock: map['productOutOfStock'] as bool? ?? false,
        );

  CartProductModel copyWith({
    String? id,
    String? productId,
    int? quantity,
    String? productName,
    String? productImage,
    double? productPrice,
    String? selectedSize,
    Color? selectedColor,
    bool? productExists,
    bool? productOutOfStock,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      productExists: productExists ?? this.productExists,
      productOutOfStock: productOutOfStock ?? this.productOutOfStock,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'product': productId,
      'quantity': quantity,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      if (selectedSize != null) 'selectedSize': selectedSize,
      if (selectedColor != null) 'selectedColor': selectedColor!.hex,
    };
  }

  String toJson() => jsonEncode(toMap());
}
