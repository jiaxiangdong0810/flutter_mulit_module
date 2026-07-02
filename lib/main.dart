import 'package:flutter/material.dart';
import 'package:service/service.dart';
import 'package:logger/register.dart';
import 'package:storage/register.dart';
import 'package:module_home/module_home.dart';
import 'package:module_mine/module_mine.dart';
import 'config/flavor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化日志服务并注册到 ServiceRegistry
  ServiceRegistry.register<ILog>(initLogService());

  // 初始化存储服务并注册到 ServiceRegistry
  ServiceRegistry.register<IStorage>(await initStorageService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Flavor.current.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    MinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '主页'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
