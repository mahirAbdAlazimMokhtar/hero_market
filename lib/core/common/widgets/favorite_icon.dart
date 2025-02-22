import 'package:flutter/material.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'dart:math' show Random;

import 'package:iconly/iconly.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key, required this.productId});
  final String productId;
  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = Random().nextBool();
  }

  @override
  Widget build(BuildContext context) {
   return IconButton(
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      icon: Icon(
        isFavorite ? IconlyBold.heart : IconlyBroken.heart,
        color: AppColors.lightThemeSecondaryColor,
      ),
    );
  }
}
