import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String? street;
  final String? city;
  final String? apartment;
  final String? postalCode;
  final String? country;

  const Address(
      {required this.street,
      required this.city,
      required this.apartment,
      required this.postalCode,
      required this.country});

  bool get isEmpty =>
      street == null &&
      city == null &&
      apartment == null &&
      postalCode == null &&
      country == null;

  bool get isNotEmpty => !isEmpty;
  
  const Address.empty()
      : street = 'Test String street',
        apartment = 'Test String apartment',
        city = 'Test String city',
        postalCode = 'Test String postalCode',
        country = 'Test String country';

  @override
  List<Object?> get props => [street, city, apartment, postalCode, country];
}
