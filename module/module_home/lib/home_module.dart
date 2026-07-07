import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'home_page.dart';

class HomeModule extends AppModule {
  const HomeModule();

  @override
  String get id => 'home';

  @override
  String get label => '主页';

  @override
  Widget buildPage(BuildContext context) => const HomePage();
}
