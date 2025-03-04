import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/common/widgets/app_bar_bottom.dart';
import 'package:hero_market/core/common/widgets/search_button.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/src/product/presentation/widgets/paginated_product_grid_view.dart';

import '../app/adapter/cubit/product_cubit.dart';
import '../app/state_manager/search_controller.dart';
import '../widgets/category_selector.dart';

class AllNewArrivalsView extends StatelessWidget {
  const AllNewArrivalsView({super.key});
  static const path = 'new-arrivals';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Arrivals'),
        bottom: const AppBarBottom(),
        actions: [
          const SearchButton(
            padding: EdgeInsets.only(right: 10),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 30),
            child: BlocProvider(
              create: (_) => sl<ProductCubit>(),
              child: const CategorySelector(),
            ),
          ),
          const Gap(20),
          Expanded(
            child: PaginatedProductGridView(fetchRequest: (page) {
              final category = context.read<SearchControllers>().selectedCategory;
              String? categoryId;
              if (category.name?.toLowerCase() != 'all') {
                categoryId = category.id;
              }
              context
                  .read<ProductCubit>()
                  .getNewArrivals(page: page, categoryId: categoryId);
            }),
          )
        ],
      )),
    );
  }
}
