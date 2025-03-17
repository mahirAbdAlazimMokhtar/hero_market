import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_market/core/common/app/providers/user_provider.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/user/presentation/app/adapter/cubit/auth_user_cubit.dart';
import 'package:hero_market/src/wishlist/presentation/app/adapter/wishlist_cubit.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class FavoriteIconMain extends StatelessWidget {
  const FavoriteIconMain({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    // Provide the BLoCs at this level to ensure they're available
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<WishlistCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<AuthUserCubit>(),
        ),
      ],
      child: _FavoriteIconContent(productId: productId),
    );
  }
}

class _FavoriteIconContent extends StatelessWidget {
  const _FavoriteIconContent({required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, userProvider, __) {
        final user = userProvider.currentUSer;
        if (user == null) {
          return IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please login to add favorites')),
              );
            },
            icon: Icon(
              IconlyBroken.heart,
              color: AppColors.lightThemeSecondaryColor,
            ),
          );
        }

        return BlocConsumer<AuthUserCubit, AuthUserState>(
          listener: (context, authUserState) {
            if (authUserState case AuthUserError(:final message)) {
              CoreUtils.showSnackBar(context, message: message);
            }
          },
          builder: (context, authUserState) {
            bool isFavorite = false;

            // Check if product is in user's wishlist from AuthUserState
            if (authUserState is FetchedUser) {
              isFavorite = authUserState.user.wishlist.any(
                (product) => product.productId == productId,
              );
            } else {
              // Fallback to checking the current user's wishlist
              isFavorite = user.wishlist.any(
                (product) => product.productId == productId,
              );
            }
            return BlocConsumer<WishlistCubit, WishlistState>(
              listener: (context, wishlistState) {
                if (wishlistState is WishlistError) {
                  CoreUtils.showSnackBar(context,
                      message: wishlistState.message);
                }

                // تحديث AuthUserCubit بعد أي تغيير ناجح
                if (wishlistState is AddedToWishlist ||
                    wishlistState is RemovedFromWishlist) {
                  context.read<AuthUserCubit>().getUserById(user.id);
                }
              },
              builder: (context, wishlistState) {
                // تحديث الأيقونة مباشرة بناءً على حالة WishlistCubit
                bool localIsFavorite = isFavorite;

                // إذا تمت إضافة هذا المنتج للمفضلة
                if (wishlistState is AddedToWishlist &&
                    wishlistState.productId == productId) {
                  localIsFavorite = true;
                }

                // إذا تمت إزالة هذا المنتج من المفضلة
                if (wishlistState is RemovedFromWishlist &&
                    wishlistState.productId == productId) {
                  localIsFavorite = false;
                }

                if (wishlistState is RemovingFromWishlist ||
                    wishlistState is AddingToWishlist) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }

                return IconButton(
                  onPressed: () {
                    final wishlistCubit = context.read<WishlistCubit>();
                    if (localIsFavorite) {
                      wishlistCubit.removeFromWishlist(
                        userId: user.id,
                        productId: productId,
                      );
                    } else {
                      wishlistCubit.addToWishlist(
                        userId: user.id,
                        productId: productId,
                      );
                    }
                  },
                  icon: Icon(
                    localIsFavorite ? IconlyBold.heart : IconlyBroken.heart,
                    color: AppColors.lightThemeSecondaryColor,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
