import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_market/core/common/app/providers/user_provider.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';

class HomeViews extends StatelessWidget {
  const HomeViews({super.key});
  static const path = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          context.watch<UserProvider>().currentUSer!.name,
          style: context.theme.textTheme.bodyLarge?.adaptiveColor(context),
        ),
      ),
    );
  }
}
