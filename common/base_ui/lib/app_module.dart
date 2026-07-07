import 'package:flutter/material.dart';

/// 模块标准契约
/// 只定义模块的身份和能力，不涉及任何展示细节
abstract class AppModule {
  const AppModule();

  /// 模块唯一标识
  String get id;

  /// 模块名称
  String get label;

  /// 构建模块主页面
  Widget buildPage(BuildContext context);
}
