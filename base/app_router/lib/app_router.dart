import 'package:flutter/material.dart';

/// 路由中心
/// 模块注册页面，app 通过 URL 导航
class AppRouter {
  static final Map<String, WidgetBuilder> _routes = {};

  /// 注册路由
  static void register(String path, WidgetBuilder builder) {
    _routes[path] = builder;
  }

  /// 按路径构建页面，未注册返回 null
  static Widget? build(BuildContext context, String path) {
    return _routes[path]?.call(context);
  }

  /// 按路径导航，未注册则不跳转
  static void open(BuildContext context, String path) {
    final builder = _routes[path];
    if (builder == null) return;
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}
