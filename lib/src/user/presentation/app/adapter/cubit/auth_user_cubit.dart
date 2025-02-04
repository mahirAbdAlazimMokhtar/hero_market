import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_market/core/common/app/providers/user_provider.dart';
import 'package:hero_market/src/user/domain/usecases/get_user.dart';
import 'package:hero_market/src/user/domain/usecases/get_user_payment_profile.dart';
import 'package:hero_market/src/user/domain/usecases/update_user.dart';

import '../../../../../../core/common/entities/user.dart';
import '../../../../../../core/utils/typedefs.dart';

part 'auth_user_state.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  final GetUser _getUser;
  final GetUserPaymentProfile _getUserPaymentProfile;
  final UpdateUser _updateUser;
  final UserProvider _userProvider;

  AuthUserCubit({
    required GetUser getUser,
    required GetUserPaymentProfile getUserPaymentProfile,
    required UpdateUser updateUser,
    required UserProvider userProvider,
  })  : _getUser = getUser,
        _getUserPaymentProfile = getUserPaymentProfile,
        _updateUser = updateUser,
        _userProvider = userProvider,
        super(const AuthUserInitial());

  Future<void> getUserById(String userId) async {
    emit(const GettingUserData());
    final result = await _getUser(userId);
    result.fold((failure) => emit(AuthUserError(failure.errorMessage)), (user) {
      _userProvider.setUser(user);
      emit(FetchedUser(user));
    });
  }

  Future<void> getUserPaymentProfile(String userId) async {
    emit(const GettingUserPaymentProfile());
    final result = await _getUserPaymentProfile(userId);
    result.fold((failure) => emit(AuthUserError(failure.errorMessage)),
        (paymentProfile) {
      emit(FetchedUserPaymentProfile(paymentProfile));
    });
  }

  Future<void> updateUser(
      {required String userId, required DataMap updateData}) async {
    emit(const UpdatingUserData());
    final result = await _updateUser(
        UpdateUserParams(userId: userId, dataMap: updateData));
    result.fold((failure) => emit(AuthUserError(failure.errorMessage)), (user) {
      _userProvider.updateUser(user);
      emit(FetchedUser(user));
    });
  }
}
