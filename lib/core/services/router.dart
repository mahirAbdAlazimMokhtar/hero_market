import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/app/cache_helper.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/src/auth/presentation/app/screens/forgot_password_screen.dart';
import 'package:hero_market/src/auth/presentation/app/screens/login_screen.dart';
import 'package:hero_market/src/auth/presentation/app/screens/register_screen.dart';
import 'package:hero_market/src/auth/presentation/app/screens/reset_password_screen.dart';
import 'package:hero_market/src/auth/presentation/app/screens/splash_screen.dart';
import 'package:hero_market/src/auth/presentation/app/screens/verify_otp_screen.dart';
import 'package:hero_market/src/cart/presentation/views/cart_view.dart';
import 'package:hero_market/src/dashboard/presentation/views/dashboard_screen.dart';
import 'package:hero_market/src/explore/presentation/views/explore_view.dart';
import 'package:hero_market/src/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:hero_market/src/product/presentation/app/adapter/cubit/product_cubit.dart';
import 'package:hero_market/src/product/presentation/app/state_manager/search_controller.dart';
import 'package:hero_market/src/product/presentation/screen/search_view.dart';
import 'package:hero_market/src/user/presentation/app/adapter/cubit/auth_user_cubit.dart';
import 'package:hero_market/src/user/presentation/views/payment_profile_view.dart';
import 'package:provider/provider.dart';
import '../../src/auth/presentation/app/adapter/cubit/auth_cubit.dart';
import '../../src/home/presentation/views/home_views.dart';

import '../../src/product/presentation/screen/all_new_arrivals_views.dart';
import '../../src/product/presentation/screen/all_popular_products_views.dart';
import '../../src/user/presentation/views/profile_view.dart';
import '../../src/wishlist/presentation/views/wishlist_view.dart';
import '../common/singletons/cache.dart';


part 'router.main.dart';