import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/src/cart/presentation/views/cart_view.dart';
import 'package:iconly/iconly.dart';

class ReactiveCartIcon extends StatefulWidget {
  const ReactiveCartIcon({super.key});

  @override
  State<ReactiveCartIcon> createState() => _ReactiveCartIconState();
}

final countNotifier = ValueNotifier<int?>(null);

class _ReactiveCartIconState extends State<ReactiveCartIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => context.push(CartView.path),
        child: ValueListenableBuilder(
          valueListenable: countNotifier,
          builder: (_, value, __) {
            return Badge(
              backgroundColor: AppColors.lightThemeSecondaryColor,
              isLabelVisible: value != null && value > 0,
              label: value == null
                  ? null
                  : Center(
                      child: Text(value.toString(), style: TextStyle().white),
                    ),
              child: Icon(
                IconlyBroken.buy,
                size: 24,
                color: AppColors.classicAdaptiveTextColor(context),
              ),
            );
          },
        ));
  }
}
