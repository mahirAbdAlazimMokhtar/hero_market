import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

import '../../../src/product/presentation/screen/search_view.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: IconButton(
        onPressed: () => context.push(SearchView.path),
        icon: const Icon(IconlyBroken.search),
      ),
    );
  }
}
