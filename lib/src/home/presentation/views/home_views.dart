import 'package:flutter/material.dart';

class HomeViews extends StatelessWidget {
  const HomeViews({super.key});
  static const path = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Placeholder(
        child: Center(
          child: Text('To Be Continued...'),
        ),
      ),
    );
  }
}