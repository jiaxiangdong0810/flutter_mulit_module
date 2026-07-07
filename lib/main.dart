import 'package:flutter/material.dart';
import 'package:service/service.dart';
import 'package:app_logger/register.dart';
import 'package:storage/register.dart';
import 'package:app_router/app_router.dart';
import 'package:module_home/module_home.dart';
import 'package:module_mine/module_mine.dart';
import 'package:module_profile/module_profile.dart';
import 'config/flavor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceRegistry.register<ILog>(initLogService());
  ServiceRegistry.register<IStorage>(await initStorageService());

  // 注册业务模块 — 想要哪个就留着，不要就注释掉
  registerHomeModule();
  registerMineModule();
  // registerProfileModule();

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

/// 底部导航栏配置 — 只有路径、图标、名称
const List<_TabConfig> _tabs = [
  _TabConfig(path: '/home', icon: Icons.home, label: '主页'),
  _TabConfig(path: '/mine', icon: Icons.person, label: '我的'),
];

class _TabConfig {
  const _TabConfig({required this.path, required this.icon, required this.label});
  final String path;
  final IconData icon;
  final String label;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (_tabs.isEmpty) {
      return const Scaffold(body: Center(child: Text('功能暂不可用')));
    }

    final currentIndex = _currentIndex >= _tabs.length ? 0 : _currentIndex;
    final currentTab = _tabs[currentIndex];

    return Scaffold(
      body: AppRouter.build(context, currentTab.path) ??
          Center(child: Text('${currentTab.label} 暂不可用')),
      bottomNavigationBar: _tabs.length < 2
          ? null
          : BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                for (final tab in _tabs)
                  BottomNavigationBarItem(
                    icon: Icon(tab.icon),
                    label: tab.label,
                  ),
              ],
            ),
    );
  }
}
