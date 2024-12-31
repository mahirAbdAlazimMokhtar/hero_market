import 'dart:convert';

import 'package:hero_market/core/common/entities/user.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/core/common/models/address_model.dart';

import '../../../src/wishlist/data_layer/models/wishlist_product_model.dart';
import '../../../src/wishlist/domain_layer/entities/wishlist_product.dart';
import '../entities/address.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.isAdmin,
    required super.wishlist,
    super.address,
    super.phone,
  });

  const UserModel.empty()
      : this(
          id: "Test String",
          name: "Test String",
          email: "Test String",
          isAdmin: true,
          wishlist: const [],
          address: null,
          phone: null,
        );

  User copyWith({
    String? id,
    String? name,
    String? email,
    bool? isAdmin,
    List<WishlistProduct>? wishlist,
    Address? address,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      wishlist: wishlist ?? this.wishlist,
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'wishlist': wishlist
          .map((product) => (product as WishlistProductModel).toMap())
          .toList(),
      if (address != null) 'address': (address as AddressModel).toMap(),
      if (phone != null) 'phone': phone,
    };
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  factory UserModel.fromMap(DataMap map) {
    final address = AddressModel.fromMap({
      if (map case {'street': String street}) 'street': street,
      if (map case {'apartment': String apartment}) 'apartment': apartment,
      if (map case {'city': String city}) 'city': city,
      if (map case {'postalCode': String postalCode}) 'postalCode': postalCode,
      if (map case {'country': String country}) 'country': country,
    });
    return UserModel(
      id: map['id'] as String? ?? 'default_id', // Provide a default or handle null
    name: map['name'] as String? ?? 'default_name', // Provide a default or handle null
    email: map['email'] as String? ?? 'default_email', // Provide a default or handle null
    isAdmin: map['isAdmin'] as bool? ?? false, // Provide a default or handle null
    wishlist: (map['wishlist'] as List<dynamic>?)?.map((item) => WishlistProductModel.fromMap(item as DataMap)).toList().cast<WishlistProduct>() ?? [], // Handle null case
    address: address.isEmpty ? null : address,
    phone: map['phone'] as String?,
    );
  }

  String toJson() => jsonEncode(toMap());
}
// Fix this ?