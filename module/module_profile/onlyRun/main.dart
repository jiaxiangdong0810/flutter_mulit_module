import 'package:flutter/material.dart';
import 'package:module_profile/module_profile.dart';

/// module_profile 组件独立运行
void main() {
  runApp(const ProfileDemoApp());
}

class ProfileDemoApp extends StatelessWidget {
  const ProfileDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ProfilePage());
  }
}
