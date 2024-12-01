import 'package:equatable/equatable.dart';

import 'address.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool isAdmin;
  final List<WishlistProduct> wishlist;
  final Address? address;
  final String? phone;

  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.isAdmin,
      required this.wishlist,
      required this.address,
      required this.phone});


  const User.empty()
      : id = 'Test String id',
        name = 'Test String Name',
        email = 'Test String Email',
        isAdmin = true,
        wishlist = const [],
        address = null,
        phone = null;
  
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        isAdmin,
        wishlist.length,
      ];
}

class WishlistProduct {}
