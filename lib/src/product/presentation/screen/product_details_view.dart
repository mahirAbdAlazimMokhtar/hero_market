import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/common/widgets/app_bar_bottom.dart';
import 'package:hero_market/core/common/widgets/favorite_icon.dart';
import 'package:hero_market/core/common/widgets/rounded_button.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/extensions/widgets_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/cart/data/model/cart_product_model.dart';
import 'package:hero_market/src/cart/presentation/app/adapter/cart_cubit.dart';
import 'package:hero_market/src/home/presentation/widgets/reactive_cart_icon.dart';

import '../app/adapter/cubit/product_cubit.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView(this.productId, {super.key});
  final String productId;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  String? selectedSize;
  Color? selectedColor;
  @override
  void initState() {
    context.read<ProductCubit>().getProduct(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (_, state) {
        if (state case ProductError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
          if (context.canPop()) context.pop();
        }
      },
      builder: (_, productState) {
        return BlocConsumer<CartCubit, CartState>(
          listener: (context, cartState) {
            if (cartState case CartError(:final message)) {
              CoreUtils.showSnackBar(context, message: message);
            } else if (cartState is AddedToCart) {
              CoreUtils.showSnackBar(
                context,
                message: 'Product added to cart',
                backgroundColor: Colors.green,
              );
            }
          },
          builder: (_, cartState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Product Details'),
                bottom: const AppBarBottom(),
                actions: [
                  if (productState is ProductFetched) 
                    FavoriteIconMain(
                      productId: productState.product.id,
                      key: ValueKey('favorite_${productState.product.id}'),
                    ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: ReactiveCartIcon(),
                  ),
                ],
              ),
              body: Builder(builder: (_) {
                if (productState is FetchingProduct) {
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: AppColors.lightThemePrimaryColor,
                  ));
                } else if (productState case ProductFetched(:final product)) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Builder(builder: (context) {
                              var images = product.images;
                              if (images.isEmpty) {
                                images = [product.image];
                              }
                              return CarouselSlider(
                                  items: images.map((image) {
                                    return Builder(
                                        builder: (BuildContext context) {
                                      return Container(
                                        width: context.width,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF0F0F0),
                                          image: DecorationImage(
                                            image: NetworkImage(image),
                                            //fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    });
                                  }).toList(),
                                  options: CarouselOptions(
                                    height: context.height * 0.4,
                                    autoPlay: images.length > 1,
                                    viewportFraction: 1,
                                    enlargeCenterPage: true,
                                  ));
                            })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20).copyWith(bottom: 40),
                        child: RoundedButton(
                            text: 'add to cart',
                            textStyle: AppTextStyles.buttonTextHeadingSemiBold
                                .copyWith(fontSize: 16)
                                .white,
                            height: 50,
                            onPressed: () {
                              if (product.colors.isNotEmpty &&
                                  selectedColor == null) {
                                CoreUtils.showSnackBar(context,
                                    message: 'Please select color',
                                    backgroundColor: Colors.red.withAlpha(8));
                                return;
                              } else if (product.sizes.isNotEmpty &&
                                  selectedSize == null) {
                                CoreUtils.showSnackBar(context,
                                    message: 'Please select size',
                                    backgroundColor: Colors.red.withAlpha(8));
                                return;
                              }
                              context.read<CartCubit>().addToCart(
                                  userId: Cache.instance.userId!,
                                  cartProduct:
                                      const CartProductModel.empty().copyWith(
                                    productId: product.id,
                                    quantity: 1,
                                    selectedColor: selectedColor,
                                    selectedSize: selectedSize,
                                  ));
                            }).loading(cartState is AddingToCart),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
            );
          },
        );
      },
    );
  }
}
