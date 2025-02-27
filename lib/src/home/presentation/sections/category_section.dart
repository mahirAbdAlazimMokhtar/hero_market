import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/product/domain/entities/category.dart';
import 'package:hero_market/src/product/presentation/app/adapter/cubit/product_cubit.dart';

import '../../../../core/resources/styles/colors.dart';
import '../../../../core/resources/styles/text.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
    List<ProductCategory> categories = [];
  @override
  void initState() {
    context.read<ProductCubit>().getCategories();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if(state case CategoriesFetched(:final categories)){
           print("Categories received: ${categories.length}");
          this.categories = categories;
        } else if(state case ProductError(:final message)){
          CoreUtils.showSnackBar(context, message: message);
        }
      },
      builder: (context, state) {
        if (state is FetchingCategories) {
          return Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: AppColors.lightThemePrimaryColor,
          ));
        }
        if (categories.isNotEmpty) {
          return SizedBox(
            height: 95,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      // TODO (Categories) : Push to categories screen
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:category.image == null ?
                          AppColors.lightThemeSecondaryColor : null,
                          backgroundImage:category.image == null ? null :
                              NetworkImage(category.image!),
                        ),
                        const Gap(3),
                        Text(
                          category.name!,
                          style: AppTextStyles.paragraphSubTextRegular1
                              .adaptiveColor(context),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Gap(20),
                ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
