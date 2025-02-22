import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/src/home/presentation/widgets/home_product_title.dart';
import 'package:iconly/iconly.dart';

import '../../../product/data/models/product_models.dart';

class ProductSection extends StatefulWidget {
  const ProductSection.newArrivals({super.key, this.onViewAll})
      : sectionTitle = 'New Arrivals',
        productsCriteria = 'newArrivals';
  const ProductSection.popular({super.key, this.onViewAll})
      : sectionTitle = 'Popular Products',
        productsCriteria = 'popular';

  final String sectionTitle;
  final String productsCriteria;
  final VoidCallback? onViewAll;

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

final products = List.generate(10, (index) {
  return const ProductModel.empty().copyWith(
    image: 'https://picsum.photos/1080/720',
    colors: [
      Colors.red,
      Colors.blue,
      Colors.green,
    ]
  );
});

class _ProductSectionState extends State<ProductSection> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          widget.sectionTitle,
          style: AppTextStyles.buttonTextHeadingSemiBold.adaptiveColor(context),
        ),
        if (products.length > 9)
          IconButton.filled(
              onPressed: widget.onViewAll,
              style: IconButton.styleFrom(
                backgroundColor:
                    AppColors.lightThemeSecondaryTextColor.withAlpha(
                  (2),
                ),
              ),
              icon: Icon(
                IconlyBold.arrow_right,
                color: AppColors.lightThemeSecondaryColor,
              ))
      ]),
      const Gap(20),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: products.take(10).mapIndexed((index, product) {
              return HomeProductTitle(
                product,
                margin: index == 9 ? null : const EdgeInsets.only(right: 10),
              );
            }).toList(),
          ))
    ]);
  }
}
