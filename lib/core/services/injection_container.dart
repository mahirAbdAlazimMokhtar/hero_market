import 'package:get_it/get_it.dart';
import 'package:hero_market/src/auth/domain_layer/repositories/auth_repository.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/forget_password.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/verify_otp.dart';
import 'package:hero_market/src/auth/presentation/app/adapter/cubit/auth_cubit.dart';
import 'package:hero_market/src/user/app/adapter/cubit/auth_user_cubit.dart';
import 'package:hero_market/src/user/data/datasources/user_remote_data_source.dart';
import 'package:hero_market/src/user/data/repositories/user_repository_implementation.dart';
import 'package:hero_market/src/user/domain/repository/user_repo.dart';
import 'package:hero_market/src/user/domain/usecases/get_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../src/auth/data_layer/datasources/auth_remote_data_source.dart';
import '../../src/auth/data_layer/repositories/auth_repository_implementation.dart';
import '../../src/auth/domain_layer/usecases/login.dart';
import '../../src/auth/domain_layer/usecases/register.dart';
import '../../src/auth/domain_layer/usecases/reset_password.dart';
import '../../src/auth/domain_layer/usecases/verify_token.dart';
import '../../src/user/domain/usecases/get_user_payment_profile.dart';
import '../../src/user/domain/usecases/update_user.dart';
import '../common/app/cache_helper.dart';
import 'package:http/http.dart' as http;

import '../common/app/providers/user_provider.dart';

part 'injection_container.main.dart';