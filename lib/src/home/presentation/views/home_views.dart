import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/src/home/presentation/sections/home_app_bar.dart';
import 'package:hero_market/src/home/presentation/sections/product_section.dart';
import 'package:hero_market/src/home/presentation/widgets/promo_banner.dart';
import 'package:hero_market/src/product/presentation/app/adapter/cubit/product_cubit.dart';

import '../../../../core/services/injection_container.dart';
import '../sections/category_section.dart';
import '../sections/search_section.dart';

class HomeViews extends StatelessWidget {
  const HomeViews({super.key});
  static const path = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Gap(40),
              SearchSection(
                onTap: () {
                  //TODO : push to search screen
                },
              ),
              const Gap(20),
              Expanded(
                  child: ListView(
                children: [
                  //Promo Banner
                  PromoBanner(),
                  const Gap(20),
                  CategorySection(),
                  const Gap(20),
                  BlocProvider(
                    create: (_) => sl<ProductCubit>(),
                    child: ProductSection.popular(
                      onViewAll: () {
                        //TODO : push to popular screen
                      },
                    ),
                  ),
                  const Gap(20),
                  BlocProvider(
                    create: (context) => sl<ProductCubit>(),
                    child: ProductSection.newArrivals(
                      onViewAll: () {
                        //TODO : push to newArrivals screen
                      },
                    ),
                  ),
                  //New Arrivals Section
                ],
              ))
            ],
          ),
        ));
  }
}
