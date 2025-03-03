import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/widgets/favorite_icon.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';
import 'package:hero_market/src/product/presentation/widgets/color_palette.dart';

/// A [Widget] that displays a product tile.
///
/// This product tile has a different structure than the [HomeProductTile]
class ClassicProductTile extends StatelessWidget {
  /// Creates a [ClassicProductTile] widget.
  const ClassicProductTile(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push('/products/${product.id}'),
      child: Container(
        width: (context.width / 2) - 30,
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 228,
                  width: (context.width / 2) - 30,
                  decoration: BoxDecoration(
                      color: const Color(0xfff0f0f0),
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                      )),
                ),
                Positioned(
                  right: 0,
                  child: FavoriteIconMain(productId: product.id),
                ),
              ],
            ),
            const Gap(5),
            Padding(
              padding: const EdgeInsets.all(5).copyWith(top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name.truncateWithEllipsis(15),
                    maxLines: 1,
                    style: AppTextStyles.headingMedium4.adaptiveColor(context),
                  ),
                  const Gap(2),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.paragraphSubTextRegular2.grey,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.paragraphSubTextRegular3.orange,
                      ),
                      const Gap(6),
                      Flexible(
                        child: ColorPalette(
                          colors: product.colors.take(3).toList(),
                          radius: 5,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
