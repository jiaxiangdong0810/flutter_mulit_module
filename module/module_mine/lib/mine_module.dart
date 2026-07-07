import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'mine_page.dart';

class MineModule extends AppModule {
  const MineModule();

  @override
  String get id => 'mine';

  @override
  String get label => '我的';

  @override
  Widget buildPage(BuildContext context) => const MinePage();
}
