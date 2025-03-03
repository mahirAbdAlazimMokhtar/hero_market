import 'package:flutter/material.dart' hide SearchController;
import 'package:gap/gap.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/src/product/presentation/app/state_manager/search_controller.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/gender_age_category.dart';

class GenderAgeCategorySelector extends StatelessWidget {
  const GenderAgeCategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchControllers>(
      builder: (_, searchController, __) {
        final selectedGenderAgeCategory =
            searchController.selectedGenderAgeCategory;
        final selectedCategory = searchController.selectedCategory;
        if (selectedCategory.name!.toLowerCase() == 'all') {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 40,
            child: Theme(
              data: context.theme.copyWith(canvasColor: Colors.transparent),
              child: ListView.separated(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                itemCount: GenderAgeCategory.values.length,
                separatorBuilder: (_, __) => const Gap(10),
                itemBuilder: (context, index) {
                  final category = GenderAgeCategory.values[index];
                  final selected = selectedGenderAgeCategory == category;
                  return ChoiceChip(
                    label: Text(category.value),
                    labelStyle: selected
                        ? AppTextStyles.headingSemiBold1.white
                        : AppTextStyles.paragraphSubTextRegular1.grey,
                    selected: selected,
                    selectedColor: AppColors.lightThemePrimaryColor,
                    showCheckmark: false,
                    backgroundColor: Colors.transparent,
                    onSelected: (_) {
                      searchController.selectGenderAgeCategory(category);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
