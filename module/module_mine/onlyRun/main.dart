import 'package:flutter/material.dart';
import 'package:service/service.dart';
import 'package:logger/logger.dart';
import 'package:module_mine/module_mine.dart';

/// module_mine 组件独立运行
void main() {
  // 注册日志服务
  ServiceRegistry.register<ILog>(AppLog());

  runApp(const MineDemoApp());
}

class MineDemoApp extends StatelessWidget {
  const MineDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MinePage());
  }
}
