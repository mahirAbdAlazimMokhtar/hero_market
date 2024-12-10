import 'package:get_it/get_it.dart';
import 'package:hero_market/src/auth/domain_layer/repositories/auth_repository.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/forget_password.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/verify_otp.dart';
import 'package:hero_market/src/auth/presentation/app/adapter/cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../src/auth/data_layer/datasources/auth_remote_data_source.dart';
import '../../src/auth/data_layer/repositories/auth_repository_implementation.dart';
import '../../src/auth/domain_layer/usecases/login.dart';
import '../../src/auth/domain_layer/usecases/register.dart';
import '../../src/auth/domain_layer/usecases/reset_password.dart';
import '../../src/auth/domain_layer/usecases/verify_token.dart';
import '../common/app/cache_helper.dart';
import 'package:http/http.dart' as http;

part 'injection_container.main.dart';