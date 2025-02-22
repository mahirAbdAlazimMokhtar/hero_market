import 'package:flutter/material.dart';
import 'package:hero_market/core/common/widgets/input_field.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:iconly/iconly.dart';

class SearchSection extends StatefulWidget {
  const SearchSection(
      {super.key,
      this.onTap,
      this.readOnly = false,
      this.suffixIcon,
      this.controller});
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late TextEditingController controller;
  final focusNod = FocusNode();
  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNod.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '/search-section',
      flightShuttleBuilder: (context, __, ___, ____, _____) {
        return Material(
          color: context.theme.scaffoldBackgroundColor,
          child: const SearchSection(
            readOnly: true,
          ),
        );
      },
      child: InputField(
        controller: controller,
        focusNode: focusNod,
        defaultValidation: false,
        hintText: 'Search for products',
        onTapOutside: (_) => focusNod.unfocus(),
        onTap: widget.onTap,
        prefixIcon: const Icon(IconlyLight.search),
        suffixIcon: IntrinsicHeight(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            ListenableBuilder(
                listenable: focusNod,
                builder: (context, __) {
                  return VerticalDivider(
                    color: focusNod.hasFocus
                        ? AppColors.lightThemePrimaryColor
                        : AppColors.lightThemeWhiteColor,
                    indent: 10,
                    endIndent: 10,
                    width: 20,
                  );
                }),
            if (widget.suffixIcon != null)
              widget.suffixIcon!
            else
              const Icon(
                IconlyLight.filter,
                size: 18,
              )
          ]),
        ),
      ),
    );
  }
}
