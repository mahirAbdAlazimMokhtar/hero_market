import 'package:flutter/material.dart';

import '../../resources/styles/colors.dart';

class DynamicLoaderWidget extends StatelessWidget {
  const DynamicLoaderWidget(
      {super.key,
      required this.originalWidget,
      this.loadingWidget,
      required this.isLoading});
  final Widget originalWidget;
  final Widget? loadingWidget;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ??
          const Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: AppColors.lightThemeSecondaryColor,
          ));
    }
    return originalWidget;
  }
}
