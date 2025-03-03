import 'package:flutter/cupertino.dart';
import 'package:hero_market/core/enums/gender_age_category.dart';
import 'package:hero_market/src/product/domain/entities/category.dart';
import 'package:hero_market/src/product/presentation/app/adapter/cubit/product_cubit.dart';

class SearchControllers extends ChangeNotifier {
  final _queryController = TextEditingController();
  GenderAgeCategory _selectedGenderAgeCategory = GenderAgeCategory.all;
  ProductCategory _selectedCategory = const ProductCategory.all();

  TextEditingController get queryController => _queryController;

  GenderAgeCategory get selectedGenderAgeCategory => _selectedGenderAgeCategory;

  ProductCategory get selectedCategory => _selectedCategory;

  void selectGenderAgeCategory(GenderAgeCategory category) {
    if (_selectedGenderAgeCategory != category) {
      _selectedGenderAgeCategory = category;
      notifyListeners();
    }
  }

  void selectCategory(ProductCategory category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  final categoryFamilyKey = GlobalKey();
  final genderAgeCategoryFamilyKey = GlobalKey();
  final productAdapterFamilyKey = GlobalKey();
  final searchController = TextEditingController();

  final int _page = 1;

  void search({required ProductCubit productAdapter}) {
    if (_selectedCategory.name!.toLowerCase() != 'all') {
      // means that the genderAgeCategory is considered
      if (_selectedGenderAgeCategory.value.toLowerCase() != 'all') {
        // means we have a specification and they are
        // both not [all]
        productAdapter.searchByCategoryAndGenderAgeCategory(
          query: searchController.text.trim(),
          categoryId: _selectedCategory.id,
          genderAgeCategory: _selectedGenderAgeCategory.value.toLowerCase(),
          page: _page,
        );
      } else {
        // means we have only category specified
        productAdapter.searchByCategory(
          query: searchController.text.trim(),
          categoryId: _selectedCategory.id,
          page: _page,
        );
      }
    } else {
      productAdapter.searchAllProducts(
        query: searchController.text.trim(),
        page: _page,
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
