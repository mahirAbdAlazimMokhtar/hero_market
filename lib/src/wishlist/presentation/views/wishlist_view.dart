import 'package:flutter/material.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});
  static const String path = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      color: Colors.blue,
      child: Center(
        child: Text('Wishlist View'),
      ),
    );
  }
}