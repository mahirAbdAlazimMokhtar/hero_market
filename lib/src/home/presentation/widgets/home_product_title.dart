// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/widgets/favorite_icon.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';
import 'package:hero_market/src/product/presentation/widgets/color_palette.dart';

class HomeProductTitle extends StatelessWidget {
  const HomeProductTitle(this.product, {super.key, this.margin});
  final Product product;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap:  () => context.push('/products/${product.id}'),
      child: Container(
        width: 196,
        margin: margin,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: CoreUtils.adaptiveColor(context,
                lightModeColor: AppColors.lightThemeWhiteColor,
                darkModeColor: AppColors.darkThemeDarkSharpColor),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 131,
                    width: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xfff0f0f0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    // استخدام Image بدلاً من DecorationImage للتمكن من إضافة رؤوس
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        // إضافة رؤوس المصادقة

                        // إضافة معالج الأخطاء
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                          );
                        },
                        // إضافة مؤشر تحميل
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator.adaptive(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              backgroundColor: AppColors.lightThemePrimaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: FavoriteIconMain(productId: product.id),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name.truncateWithEllipsis(12),
                    style: AppTextStyles.headingMedium4.adaptiveColor(context),
                  ),
                  if (product.colors.isNotEmpty)
                    Flexible(
                        child: ColorPalette(
                      colors: product.colors.take(3).toList(),
                      radius: 5,
                    ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5).copyWith(top: 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.paragraphSubTextRegular3.orange,
                    ),
                    const Gap(6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.lightThemeYellowColor,
                          size: 11,
                        ),
                        const Gap(3),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: AppTextStyles.paragraphSubTextRegular2
                              .adaptiveColor(context),
                        )
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
