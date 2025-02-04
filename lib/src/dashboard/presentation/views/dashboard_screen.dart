import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/dashboard/presentation/app/dashboard_state.dart';
import 'package:hero_market/src/dashboard/presentation/views/widgets/dashboard_drawer.dart';
import 'package:hero_market/src/explore/presentation/views/explore_view.dart';
import 'package:hero_market/src/home/presentation/views/home_views.dart';

import '../../../cart/presentation/views/cart_view.dart';
import '../../../user/presentation/app/adapter/cubit/auth_user_cubit.dart';
import '../../../user/presentation/views/profile_view.dart';
import '../../../wishlist/presentation/views/wishlist_view.dart';
import '../utils/dashboard_utils.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.state, required this.child});
  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final activeIndex = DashboardUtils.activeIndex(state);
    return Scaffold(
      key: DashboardUtils.scaffoldKey,
      body: child,
      drawer: BlocProvider(
        create: (_) => sl<AuthUserCubit>(),
        child: DashboardDrawer(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: DashboardState.instance.indexNotifier,
        builder: (_, currentIndex, __) {
          return CurvedNavigationBar(
            index: currentIndex,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            color: CoreUtils.adaptiveColor(context,
                lightModeColor: AppColors.lightThemeWhiteColor,
                darkModeColor: AppColors.darkThemeDarkSharpColor),
            buttonBackgroundColor: AppColors.lightThemePrimaryColor,
            items: DashboardUtils.iconList.mapIndexed((index, icon) {
              final isActive = activeIndex == index;
              return Icon(
                isActive ? icon.active : icon.idle,
                size: 30,
                color: isActive
                    ? AppColors.lightThemeWhiteColor
                    : AppColors.lightThemePrimaryColor,
              );
            }).toList(),
            onTap: (index) async {
              final currentIndex = activeIndex;
              DashboardState.instance.changeIndex(index);
              switch (index) {
                case 0:
                  context.go(HomeViews.path);
                case 1:
                  context.go(ExploreView.path);
                case 2:
                  await context.push(CartView.path);
                  DashboardState.instance.changeIndex(currentIndex);
                case 3:
                  context.go(WishlistView.path);
                case 4:
                  await context.push(ProfileView.path);
                  DashboardState.instance.changeIndex(currentIndex);
              }
            },
          );
        },
      ),
    );
  }
}
