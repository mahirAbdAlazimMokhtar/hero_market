import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/common/widgets/app_bar_bottom.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/src/home/presentation/sections/search_section.dart';
import 'package:hero_market/src/product/presentation/app/adapter/cubit/product_cubit.dart';
import 'package:hero_market/src/product/presentation/app/state_manager/search_controller.dart';
import 'package:hero_market/src/product/presentation/widgets/category_selector.dart';
import 'package:hero_market/src/product/presentation/widgets/gender_age_category_selector.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';

import '../widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static const path = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search'), bottom: const AppBarBottom()),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchSection(
                    controller:
                        context.read<SearchControllers>().queryController,
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                      context.read<SearchControllers>().search(
                            productAdapter: context.read<ProductCubit>(),
                          );
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<SearchControllers>().search(
                              productAdapter: context.read<ProductCubit>(),
                            );
                      },
                      icon: const Iconify(
                        Majesticons.send,
                        color: AppColors.lightThemePrimaryColor,
                      ),
                    ),
                  ),
                  const Gap(20),
                  BlocProvider(
                    create: (_) => sl<ProductCubit>(),
                    child: const CategorySelector(),
                  ),
                  const GenderAgeCategorySelector(),
                ],
              ),
            ),
            const Expanded(child: SearchViewBody()),
          ],
        ),
      ),
    );
  }
}
