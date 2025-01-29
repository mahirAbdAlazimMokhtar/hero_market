import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String path = '/profile';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Text('Profile View'),
      ),
    );
  }
}