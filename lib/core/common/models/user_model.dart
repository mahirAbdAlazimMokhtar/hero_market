import 'package:hero_market/core/common/entities/user.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/core/common/models/address_model.dart';

import '../../../src/wishlist/data_layer/models/wishlist_product_model.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.isAdmin,
      required super.wishlist,
      required super.address,
      required super.phone});

  const UserModel.empty()
      : this(
            id: 'Test String id',
            name: 'Test String Name',
            email: 'Test String Email',
            isAdmin: true,
            wishlist: const [],
            address: null,
            phone: null);



  factory UserModel.fromMap(Map<String, dynamic> map) {
    final address = AddressModel.fromMap({
      if (map case {'street': String street}) 'street': street,
      if (map case {'city': String city}) 'city': city,
      if (map case {'country': String country}) 'country': country,
      if (map case {'postalCode': String postalCode}) 'postalCode': postalCode,
      if (map case {'apartment': String apartment}) 'apartment': apartment
    });
    return UserModel(
      id: map['id'] as String? ?? map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      isAdmin: map['isAdmin'] as bool,
      wishlist: List<DataMap>.from(map['wishlist'] as List)
          .map((data) => WishlistProductModel.fromMap(data))
          .toList(),
      address: address.isEmpty ? null : address,
      phone: map['phone'] as String?,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
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
}
