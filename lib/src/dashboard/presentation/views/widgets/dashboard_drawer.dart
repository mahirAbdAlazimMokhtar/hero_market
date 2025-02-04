import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/common/widgets/rounded_button.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/extensions/widgets_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/dashboard/presentation/app/dashboard_state.dart';
import 'package:hero_market/src/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:hero_market/src/user/presentation/app/adapter/cubit/auth_user_cubit.dart';
import 'package:hero_market/src/user/presentation/views/profile_view.dart';
import 'package:hero_market/src/wishlist/presentation/views/wishlist_view.dart';



import '../../../../../core/common/app/cache_helper.dart';
import '../../../../../core/common/app/providers/user_provider.dart';
import '../../../../../core/common/widgets/bottom_sheet_card.dart';
import '../../../../../core/services/injection_container.dart';
import 'theme_toggle.dart';


class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  final signingOutNotifier = ValueNotifier(false);
  @override
  void dispose() {
    signingOutNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserProvider>().currentUSer;
   
    return BlocConsumer<AuthUserCubit, AuthUserState>(
        listener: (context, state) {
      if (state case AuthUserError(:final message)) {
        Scaffold.of(context).closeDrawer();
        CoreUtils.showSnackBar(context, message: message);
      } else if (state
          case FetchedUserPaymentProfile(:final paymentProfileUrl)) {
        context.push(ProfileView.path, extra: paymentProfileUrl);
      }
    }, builder: (context, state) {
      return Drawer(
        backgroundColor: CoreUtils.adaptiveColor(context,
            lightModeColor: AppColors.lightThemeWhiteColor,
            darkModeColor: AppColors.darkThemeDarkSharpColor),
        child: Column(
          children: [
            Gap((20)),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.lightThemePrimaryColor,
                      child: Center(
                        child: Text(
                          currentUser!.name.initials,
                          style: AppTextStyles.headingMedium.white,
                        ),
                      ),
                    ),
                    Gap((15)),
                    Text(
                      currentUser.name,
                      style: AppTextStyles.headingMedium.adaptiveColor(context),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView.separated(
                separatorBuilder: (_, __) => Divider(
                  color: CoreUtils.adaptiveColor(context,
                      lightModeColor: AppColors.lightThemeWhiteColor,
                      darkModeColor: AppColors.darkThemeDarkNavBarColor),
                ),
                itemCount: DashboardUtils.drawerItems.length,
                itemBuilder: (_, index) {
                  final drawerItem = DashboardUtils.drawerItems[index];
                  return ListTile(
                      leading: Icon(
                        drawerItem.icon,
                        color: AppColors.classicAdaptiveTextColor(context),
                      ),
                      title: Text(
                        drawerItem.title,
                        style:
                            AppTextStyles.headingMedium3.adaptiveColor(context),
                      ).loading(
                        index == 1 && state is GettingUserPaymentProfile,
                      ),
                      onTap: () {
                        if (index != 1) Scaffold.of(context).closeDrawer();
                        switch (index) {
                          case 0:
                            context.push(ProfileView.path);
                          case 1:
                            context
                                .read<AuthUserCubit>()
                                .getUserPaymentProfile(Cache.instance.userId!);
                          case 2:
                            DashboardState.instance.changeIndex(3);
                            context.go(WishlistView.path);
                          case 3:
                          //: implement my orders
                        }
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                bottom: 50,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ThemeToggle(),
                  const Gap(10),
                  ValueListenableBuilder(
                    valueListenable: signingOutNotifier,
                    builder: (_, value, __) {
                      return RoundedButton(
                        text: 'Sign Out',
                        height: 50,
                        onPressed: () async {
                          final router = GoRouter.of(context);
                          final result = await showModalBottomSheet<bool>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            isDismissible: false,
                            builder: (_) {
                              return BottomSheetCard(
                                title: 'Are you sure you want to sign out?',
                                positiveButtonText: 'Yes',
                                negativeButtonText: 'Cancel',
                                positiveButtonColor:
                                    AppColors.lightThemeSecondaryColor,
                              );
                            },
                          );
                          if (result ?? false) {
                            signingOutNotifier.value = true;
                            await sl<CacheHelper>().resetSession();
                            router.go('/');
                          }
                        },
                      ).loading(value);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
