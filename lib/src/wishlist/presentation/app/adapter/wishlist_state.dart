part of 'wishlist_cubit.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

final class AddingToWishlist extends WishlistState {
  const AddingToWishlist();
}

final class RemovingFromWishlist extends WishlistState {
  const RemovingFromWishlist();
}

final class GettingUserWishlist extends WishlistState {
  const GettingUserWishlist();
}

final class AddedToWishlist extends WishlistState {
  final String productId;
  const AddedToWishlist({required this.productId});
  
  @override
  List<Object> get props => [productId];
}
final class RemovedFromWishlist extends WishlistState {
  final String productId;
  const RemovedFromWishlist({required this.productId});
}

final class FetchedUserWishlist extends WishlistState {
  const FetchedUserWishlist(this.wishlist);

  final List<WishlistProduct> wishlist;

  @override
  List<Object> get props => wishlist;
}

final class WishlistError extends WishlistState {
  const WishlistError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
