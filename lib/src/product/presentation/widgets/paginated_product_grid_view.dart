import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/src/product/presentation/app/state_manager/search_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/widgets/classic_product_title.dart';
import '../../../../core/common/widgets/empty_data.dart';
import '../../../../core/utils/constants/network_constants.dart';
import '../../../../core/utils/core_utils.dart';
import '../../domain/entities/product.dart';
import '../app/adapter/cubit/product_cubit.dart';

class PaginatedProductGridView extends StatefulWidget {
  const PaginatedProductGridView({required this.fetchRequest, super.key});

  final ValueChanged<int> fetchRequest;

  @override
  State<PaginatedProductGridView> createState() =>
      _PaginatedProductGridViewState();
}

class _PaginatedProductGridViewState extends State<PaginatedProductGridView> {
  final pageController = PagingController<int, Product>(firstPageKey: 1);

  int currentPage = 1;

  late SearchControllers searchController;

  @override
  void initState() {
    super.initState();
    super.initState();
    pageController.addPageRequestListener((pageKey) {
      currentPage = pageKey;
      widget.fetchRequest(pageKey);
    });

    searchController = context.read<SearchControllers>()
      ..addListener(searchControllerListener);
  }

  void searchControllerListener() {
    pageController.refresh();
  }

  @override
  void dispose() {
    pageController.dispose();
    searchController.removeListener(searchControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => pageController.refresh()),
      child: BlocListener<ProductCubit, ProductState>(
        listener: (_, state) {
          if (state case ProductError(:final message)) {
            pageController.error = message;
            // redundant
            CoreUtils.showSnackBar(
              context,
              message: '$message\nPULL TO REFRESH',
            );
          } else if (state case ProductsFetched(:final products)) {
            final isLastPage = products.length < NetworkConstants.pageSize;
            if (isLastPage) {
              pageController.appendLastPage(products);
            } else {
              final nextPage = currentPage + 1;
              pageController.appendPage(products, nextPage);
            }
          }
        },
        child: PagedMasonryGridView<int, Product>.count(
          pagingController: pageController,
          crossAxisCount: 2,
          builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, product, index) => Center(
              child: ClassicProductTile(product),
            ),
            firstPageProgressIndicatorBuilder: (_) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.lightThemePrimaryColor,
                ),
              );
            },
            newPageProgressIndicatorBuilder: (_) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.lightThemePrimaryColor,
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (_) {
              return Consumer<SearchControllers>(
                builder: (_, controller, __) {
                  final categorySelected =
                      controller.selectedCategory.name?.toLowerCase() != 'all';
                  return Center(
                    child: EmptyData(
                      categorySelected
                          ? 'No products found for this category'
                          : 'No products found',
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
