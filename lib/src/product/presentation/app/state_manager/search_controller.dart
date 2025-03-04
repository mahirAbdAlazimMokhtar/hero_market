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
  final query = _queryController.text.trim(); // استخدم نفس `queryController`

  if (query.isEmpty) return; // تجنب البحث إذا كان الإدخال فارغًا

  final int page = 1; // إعادة تعيين الصفحة عند البحث الجديد

  if (_selectedCategory.name!.toLowerCase() != 'all') {
    if (_selectedGenderAgeCategory.value.toLowerCase() != 'all') {
      productAdapter.searchByCategoryAndGenderAgeCategory(
        query: query,
        categoryId: _selectedCategory.id,
        genderAgeCategory: _selectedGenderAgeCategory.value.toLowerCase(),
        page: page,
      );
    } else {
      productAdapter.searchByCategory(
        query: query,
        categoryId: _selectedCategory.id,
        page: page,
      );
    }
  } else {
    productAdapter.searchAllProducts(
      query: query,
      page: page,
    );
  }

  notifyListeners(); // تأكد من تحديث الواجهة بعد البحث
}


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
