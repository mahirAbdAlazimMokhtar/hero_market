import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/src/cart/presentation/app/adapter/cart_cubit.dart';

sealed class GlobalInterfaceAdapters {
  static final homeCarCubit = sl<CartCubit>();
}
 