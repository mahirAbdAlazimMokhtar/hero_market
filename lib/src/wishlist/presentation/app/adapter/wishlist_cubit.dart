import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/usecases/add_to_wishlist.dart';
import '../../../domain/entities/wishlist_product.dart';
import '../../../domain/usecases/get_wishlist.dart';
import '../../../domain/usecases/remove_wishlist.from.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({
    required AddToWishlist addToWishlist,
    required GetWishlist getWishlist,
    required RemoveFromWishlist removeFromWishlist,
  })  : _addToWishlist = addToWishlist,
        _getWishlist = getWishlist,
        _removeFromWishlist = removeFromWishlist,
        super(const WishlistInitial());

  final AddToWishlist _addToWishlist;
  final GetWishlist _getWishlist;
  final RemoveFromWishlist _removeFromWishlist;

  Future<void> getWishlist(String userId) async {
    emit(const GettingUserWishlist());
    final result = await _getWishlist(userId);
    result.fold(
      (failure) => emit(WishlistError(failure.errorMessage)),
      (wishlist) => emit(FetchedUserWishlist(wishlist)),
    );
  }

  Future<void> addToWishlist({
    required String userId,
    required String productId,
  }) async {
    emit(const AddingToWishlist());
    final result = await _addToWishlist(
      AddToWishlistParams(userId: userId, productId: productId),
    );
    result.fold(
      (failure) => emit(WishlistError(failure.errorMessage)),
      (_) => emit(const AddedToWishlist()),
    );
  }

  Future<void> removeFromWishlist({
    required String userId,
    required String productId,
  }) async {
    emit(const RemovingFromWishlist());
    final result = await _removeFromWishlist(
      RemoveFromWishlistParams(userId: userId, productId: productId),
    );
    result.fold(
      (failure) => emit(WishlistError(failure.errorMessage)),
      (_) => emit(const RemovedFromWishlist()),
    );
  }
}
