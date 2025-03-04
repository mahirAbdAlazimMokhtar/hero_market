import 'package:flutter/material.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}