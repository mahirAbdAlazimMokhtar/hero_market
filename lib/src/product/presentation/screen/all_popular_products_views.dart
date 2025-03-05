import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/common/widgets/app_bar_bottom.dart';
import 'package:hero_market/core/common/widgets/search_button.dart';
import 'package:hero_market/src/product/presentation/widgets/category_selector.dart';

import '../../../../core/services/injection_container.dart';
import '../app/adapter/cubit/product_cubit.dart';
import '../app/state_manager/search_controller.dart';
import '../widgets/paginated_product_grid_view.dart';

class AllPopularView extends StatelessWidget {
  const AllPopularView({super.key});

  static const path = 'popular';

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Products'),
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
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if(state is ProductLoading){
                return const LinearProgressIndicator();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 30),
                child: BlocProvider(
                  create: (_) => sl<ProductCubit>(),
                  child: const CategorySelector(),
                ),
              );
            },
          ),
          //const GenderAgeCategorySelector(),
          const Gap(20),
          Expanded(
            child: PaginatedProductGridView(fetchRequest: (page) {
              final category =
                  context.read<SearchControllers>().selectedCategory;
              String? categoryId;
              if (category.name?.toLowerCase() != 'all') {
                categoryId = category.id;
              }
              context
                  .read<ProductCubit>()
                  .getPopular(page: page, categoryId: categoryId);
            }),
          )
        ],
      )),
    );
  }
}