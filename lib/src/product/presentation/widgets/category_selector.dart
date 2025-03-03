import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/product/domain/entities/category.dart';
import 'package:hero_market/src/product/presentation/app/adapter/cubit/product_cubit.dart';
import 'package:hero_market/src/product/presentation/app/state_manager/search_controller.dart';
import 'package:provider/provider.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  void selectCategory(ProductCategory category) {
    context.read<SearchControllers>().selectCategory(category);
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchControllers>(
      builder: (_, searchController, __) {
        final selectedCategory = searchController.selectedCategory;
        return BlocConsumer<ProductCubit, ProductState>(
          listener: (_, state) {
            if (state case ProductError(:final message)) {
              CoreUtils.showSnackBar(context, message: message);
              context.pop();
            } else if (state case CategoriesFetched(:final categories)
                when categories.isEmpty) {
              CoreUtils.showSnackBar(
                context,
                message: 'No categories found.\nContact admin',
              );
              context.pop();
            }
          },
          builder: (_, state) {
            if (state is ProductError) return const SizedBox.shrink();
            if (state is FetchingCategories) {
              return const LinearProgressIndicator();
            }
            final CategoriesFetched(:categories) = state as CategoriesFetched;
            return SizedBox(
              height: 40,
              child: Theme(
                data: context.theme.copyWith(canvasColor: Colors.transparent),
                child: ListView.separated(
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1,
                  separatorBuilder: (_, __) => const Gap(10),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final selected =
                          selectedCategory.name!.toLowerCase() == 'all';
                      return ChoiceChip(
                        label: const Text('All'),
                        labelStyle: selected
                            ? AppTextStyles.headingSemiBold1.white
                            : AppTextStyles.paragraphSubTextRegular1.grey,
                        selected: selected,
                        selectedColor: AppColors.lightThemePrimaryColor,
                        showCheckmark: false,
                        backgroundColor: Colors.transparent,
                        onSelected: (_) {
                          selectCategory(const ProductCategory.all());
                        },
                      );
                    }
                    final category = categories[index - 1];
                    final selected = selectedCategory == category;
                    return ChoiceChip(
                      label: Text(category.name!),
                      labelStyle: selected
                          ? AppTextStyles.headingSemiBold1.white
                          : AppTextStyles.paragraphSubTextRegular1.grey,
                      selected: selected,
                      selectedColor: AppColors.lightThemePrimaryColor,
                      showCheckmark: false,
                      backgroundColor: Colors.transparent,
                      onSelected: (_) => selectCategory(category),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
