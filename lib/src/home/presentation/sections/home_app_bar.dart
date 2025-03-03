import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/common/widgets/app_bar_bottom.dart';
import 'package:hero_market/core/common/widgets/hero_logo.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/utils/global_interface_adapters.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/common/widgets/menu_icon.dart';
import '../../../../core/utils/core_utils.dart';
import '../widgets/reactive_cart_icon.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final adaptiveColor = AppColors.classicAdaptiveTextColor(context);
    return AppBar(
      leading: MenuIcon(),
      centerTitle: false,
      bottom: const AppBarBottom(),
      titleSpacing: 0,
      title: HeroLogo(
        style: AppTextStyles.headingSemiBold.copyWith(
          color: CoreUtils.adaptiveColor(context,
              lightModeColor: AppColors.lightThemePrimaryColor,
              darkModeColor: AppColors.lightThemePrimaryTint),
        ),
      ),
      actions: [
        BlocProvider(
          create: (context) => GlobalInterfaceAdapters.homeCarCubit,
          child: ReactiveCartIcon(),
        ),
        const Gap(20),
        Icon(
          IconlyBold.scan,
          color: adaptiveColor,
        ),
        const Gap(20),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
