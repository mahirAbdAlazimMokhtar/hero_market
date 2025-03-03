import 'dart:convert';

import 'package:hero_market/core/common/entities/user.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/core/common/models/address_model.dart';

import '../../../src/wishlist/data/models/wishlist_product_model.dart';
import '../../../src/wishlist/domain/entities/wishlist_product.dart';
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
  // بناء العنوان
  final address = AddressModel.fromMap({
    if (map case {'street': String street}) 'street': street,
    if (map case {'apartment': String apartment}) 'apartment': apartment,
    if (map case {'city': String city}) 'city': city,
    if (map case {'postalCode': String postalCode}) 'postalCode': postalCode,
    if (map case {'country': String country}) 'country': country,
  });

  // الحقول الافتراضية والتحقق
  final id = map['id'] as String? ?? map['_id'] as String? ?? '';
  final name = map['name'] as String? ?? 'Unknown';
  final email = map['email'] as String? ?? '';
  final isAdmin = map['isAdmin'] as bool? ?? false;
  final wishlist = (map['wishlist'] as List?)
          ?.map((item) => WishlistProductModel.fromMap(item as DataMap))
          .toList() ??
      [];

  // إنشاء UserModel
  return UserModel(
    id: id,
    name: name,
    email: email,
    isAdmin: isAdmin,
    wishlist: wishlist,
    address: address.isEmpty ? null : address,
    phone: map['phone'] as String?,
  );
}

  String toJson() => jsonEncode(toMap());
}
