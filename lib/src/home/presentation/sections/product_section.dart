import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/src/home/presentation/widgets/home_product_title.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';
import 'package:hero_market/src/product/presentation/app/adapter/cubit/product_cubit.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/utils/core_utils.dart';

class ProductSection extends StatefulWidget {
  const ProductSection.newArrivals({super.key, this.onViewAll})
      : sectionTitle = 'New Arrivals',
        productsCriteria = NEW_ARRIVALS;
  const ProductSection.popular({super.key, this.onViewAll})
      : sectionTitle = 'Popular Products',
        productsCriteria = POPULAR;
  static const POPULAR = 'popular';
  static const NEW_ARRIVALS = 'newArrivals';

  final String sectionTitle;
  final String productsCriteria;
  final VoidCallback? onViewAll;

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    if (widget.productsCriteria == ProductSection.POPULAR) {
      context.read<ProductCubit>().getPopular(page: 1);
    } else if (widget.productsCriteria == ProductSection.NEW_ARRIVALS) {
      context.read<ProductCubit>().getNewArrivals(page: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state case ProductsFetched(:final products)) {
          this.products = products;
        } else if (state case ProductError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        }
      },
      builder: (context, state) {
        if (state is FetchingCategories) {
          return Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: AppColors.lightThemePrimaryColor,
          ));
        }
        if (products.isNotEmpty) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.sectionTitle,
                        style: AppTextStyles.buttonTextHeadingSemiBold
                            .adaptiveColor(context),
                      ),
                      if (products.length > 9)
                        IconButton.filled(
                            onPressed: widget.onViewAll,
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors
                                  .lightThemeSecondaryTextColor
                                  .withAlpha(
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
                          margin: index == 9
                              ? null
                              : const EdgeInsets.only(right: 10),
                        );
                      }).toList(),
                    ))
              ]);
        }
        return SizedBox.shrink();
      },
    );
  }
}
