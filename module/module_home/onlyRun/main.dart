import 'package:flutter/material.dart';
import 'package:service/service.dart';
import 'package:logger/logger.dart';
import 'package:storage/storage.dart';
import 'package:module_home/module_home.dart';

/// module_home 组件独立运行
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 注册服务实现
  ServiceRegistry.register<ILog>(AppLog());
  ServiceRegistry.register<IStorage>(AppStorage());
  await ServiceRegistry.get<IStorage>().init();

  runApp(const HomeDemoApp());
}

class HomeDemoApp extends StatelessWidget {
  const HomeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}
