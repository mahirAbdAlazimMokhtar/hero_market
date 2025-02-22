import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';

import '../../../../core/resources/styles/colors.dart';
import '../../../../core/resources/styles/text.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // TODO (Categories) : Push to categories screen
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.lightThemeSecondaryColor,
                    backgroundImage:
                        NetworkImage('https://picsum.photos/200/300'),
                  ),
                  const Gap(3),
                  Text(
                    switch (index) {
                      1 => 'Shoes',
                      2 => 'Dresses',
                      3 => 'Furniture',
                      4 => 'Gadgets',
                      5 => 'Kitchen',
                      6 => 'Laptop',
                      7 => 'Home Applications',
                      8 => 'Perfumes',
                      9 => 'Jewelries',
                      _ => 'Watches',
                    },
                    style: AppTextStyles.paragraphSubTextRegular1
                        .adaptiveColor(context),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const Gap(20),
          itemCount: 10),
    );
  }
}
