import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:hero_market/src/cart/domain/entities/cart_product.dart';
import 'package:hero_market/src/cart/domain/usecases/add_to_cart.dart';
import 'package:hero_market/src/cart/domain/usecases/change_cart_product_quantity.dart';
import 'package:hero_market/src/cart/domain/usecases/get_cart.dart';
import 'package:hero_market/src/cart/domain/usecases/get_cart_count.dart';
import 'package:hero_market/src/cart/domain/usecases/get_cart_product.dart';
import 'package:hero_market/src/cart/domain/usecases/initiate_checkout.dart';
import 'package:hero_market/src/cart/domain/usecases/remove_from_cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required AddToCart addToCart,
    required ChangeCartProductQuantity changeCartProductQuantity,
    required GetCart getCart,
    required GetCartCount getCartCount,
    required GetCartProduct getCartProduct,
    required RemoveFromCart removeFromCart,
    required InitiateCheckout initiateCheckout,
  })  : _addToCart = addToCart,
        _changeCartProductQuantity = changeCartProductQuantity,
        _getCart = getCart,
        _getCartCount = getCartCount,
        _getCartProduct = getCartProduct,
        _removeFromCart = removeFromCart,
        _initiateCheckout = initiateCheckout,
        super(const CartInitial());

  final AddToCart _addToCart;
  final ChangeCartProductQuantity _changeCartProductQuantity;
  final GetCart _getCart;
  final GetCartCount _getCartCount;
  final GetCartProduct _getCartProduct;
  final RemoveFromCart _removeFromCart;
  final InitiateCheckout _initiateCheckout;

  Future<void> addToCart({
    required String userId,
    required CartProduct cartProduct,
  }) async {
    emit(const AddingToCart());

    final result = await _addToCart(
      AddToCartParams(userId: userId, cartProduct: cartProduct),
    );

    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      // TODO(Implementation): Call the get cart count on the home page
      (_) => emit(const AddedToCart()),
    );
  }

  Future<void> changeCartProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  }) async {
    emit(const ChangingCartProductQuantity());

    final result = await _changeCartProductQuantity(
      ChangeCartProductQuantityParams(
        userId: userId,
        cartProductId: cartProductId,
        newQuantity: newQuantity,
      ),
    );

    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      (_) => emit(const ChangedCartProductQuantity()),
    );
  }

  Future<void> getCart(String userId) async {
    emit(const FetchingCart());

    final result = await _getCart(userId);

    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      (cart) => emit(CartFetched(cart)),
    );
  }

  Future<void> getCartCount(String userId) async {
    emit(const FetchingCartCount());

    final result = await _getCartCount(userId);

    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      (count) => emit(CartCountFetched(count)),
    );
  }

  Future<void> getCartProduct({
    required String userId,
    required String cartProductId,
  }) async {
    emit(const FetchingCartProduct());

    final result = await _getCartProduct(
      GetCartProductParams(userId: userId, cartProductId: cartProductId),
    );

    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      (cartProduct) => emit(CartProductFetched(cartProduct)),
    );
  }

  Future<void> removeFromCart({
    required String userId,
    required String cartProductId,
  }) async {
    emit(const RemovingFromCart());

    final result = await _removeFromCart(
      RemoveFromCartParams(userId: userId, cartProductId: cartProductId),
    );

    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      // TODO(Implementation): Call the get cart count on the home page
      (_) => emit(const RemovedFromCart()),
    );
  }

  Future<void> initiateCheckout({
    required String theme,
    required List<CartProduct> cartItems,
  }) async {
    emit(const InitiatingCheckout());

    final result = await _initiateCheckout(
      InitiateCheckoutParams(theme: theme, cartItems: cartItems),
    );

    result.fold(
      (failure) => emit(CartError(failure.errorMessage)),
      (sessionUrl) => emit(CheckoutInitiated(sessionUrl)),
    );
  }
}
