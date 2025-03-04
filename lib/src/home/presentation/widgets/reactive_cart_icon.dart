import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/cart/presentation/app/adapter/cart_cubit.dart';
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
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
       if(state case CartError(:final message)){
         CoreUtils.showSnackBar(context, message: message);
       }else if (state case CartCountFetched(:final count)){
         countNotifier.value = count;
       }
      },
      builder: (context, state) {
        return GestureDetector(
            onTap: () => context.push(CartView.path),
            child: ValueListenableBuilder(
              valueListenable: countNotifier,
              builder: (_, value, __) {
                return Badge.count(
                  backgroundColor: AppColors.lightThemeSecondaryColor,
                  isLabelVisible: value != null && value > 0,
                  count: value ?? 0,
                  child: Icon(
                    IconlyBroken.buy,
                    size: 24,
                    color: AppColors.classicAdaptiveTextColor(context),
                  ),
                );
              },
            ));
      },
    );
  }
}
