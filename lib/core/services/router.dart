import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/app/cache_helper.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/forget_password.dart';
import 'package:hero_market/src/auth/presentation/app/screens/forgot_password_screen.dart';
import 'package:hero_market/src/auth/presentation/app/screens/login_screen.dart';
import 'package:hero_market/src/auth/presentation/app/screens/register_screen.dart';
import 'package:hero_market/src/auth/presentation/app/screens/splash_screen.dart';
import 'package:hero_market/src/dashboard/presentation/views/dashboard_screen.dart';
import 'package:hero_market/src/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:hero_market/src/user/app/adapter/cubit/auth_user_cubit.dart';
import '../../src/auth/presentation/app/adapter/cubit/auth_cubit.dart';
import '../../src/home/presentation/views/home_views.dart';

import '../common/singletons/cache.dart';


part 'router.main.dart';