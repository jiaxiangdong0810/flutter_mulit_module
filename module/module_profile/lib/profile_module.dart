import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'profile_page.dart';

class ProfileModule extends AppModule {
  const ProfileModule();

  @override
  String get id => 'profile';

  @override
  String get label => '个人信息';

  @override
  Widget buildPage(BuildContext context) => const ProfilePage();
}
