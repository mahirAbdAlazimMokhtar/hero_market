
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common/widgets/classic_product_title.dart';
import '../../../../core/common/widgets/empty_data.dart';
import '../../../../core/resources/media/media.dart';
import '../../../../core/utils/core_utils.dart';
import '../app/adapter/cubit/product_cubit.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (_, state) {
        if (state case ProductError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        }
      },
      builder: (context, state) {
        if (state is SearchingProduct) {
          return Center(child: Lottie.asset(Media.searching));
        } else if (state case ProductsFetched(:final products)) {
          if (products.isEmpty) {
            return const Center(child: EmptyData('No Products Found'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Center(
                child: Wrap(
                  runSpacing: 10,
                  runAlignment: WrapAlignment.center,
                  spacing: 10,
                  children: products.map(ClassicProductTile.new).toList(),
                ),
              ),
            ),
          );
        }
        return Center(
          child: Lottie.asset(
            context.isDarkMode ? Media.search : Media.searchLight,
          ),
        );
      },
    );
  }
}
