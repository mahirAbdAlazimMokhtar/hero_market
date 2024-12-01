import 'package:hero_market/core/utils/typedefs.dart';

abstract class UsecasesWithParams<Type, Params> {
  const UsecasesWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UsecasesWithoutParams<Type> {
  const UsecasesWithoutParams();

  ResultFuture<Type> call();
}
