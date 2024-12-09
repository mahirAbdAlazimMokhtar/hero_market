import 'dart:convert';

import 'package:hero_market/core/utils/typedefs.dart';

import '../entities/address.dart';

class AddressModel extends Address {
  const AddressModel(
      {required super.street,
      required super.city,
      required super.apartment,
      required super.postalCode,
      required super.country});

  const AddressModel.empty()
      : this(
            street: 'Test String street',
            apartment: 'Test String apartment',
            city: 'Test String city',
            postalCode: 'Test String postalCode',
            country: 'Test String country');

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(jsonDecode(source) as DataMap);

  AddressModel.fromMap(DataMap map)
      : this(
          street: map['street'] as String?,
          city: map['city'] as String?,
          apartment: map['apartment'] as String?,
          postalCode: map['postalCode'] as String?,
          country: map['country'] as String?,
        );

  DataMap toMap() {
    return <String, dynamic>{
      'street': street,
      'city': city,
      'apartment': apartment,
      'postalCode': postalCode,
      'country': country,
    };
  }

  AddressModel copyWith({
    String? street,
    String? city,
    String? apartment,
    String? postalCode,
    String? country,
  }) {
    return AddressModel(
      street: street ?? this.street,
      city: city ?? this.city,
      apartment: apartment ?? this.apartment,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }
  //to json
  String toJson() => jsonEncode(toMap()); 
}
