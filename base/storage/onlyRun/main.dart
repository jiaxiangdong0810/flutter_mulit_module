import 'package:flutter/material.dart';
import 'package:service/service.dart';
import 'package:storage/storage.dart';

/// storage 组件独立运行
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 注册存储服务
  ServiceRegistry.register<IStorage>(AppStorage());
  await ServiceRegistry.get<IStorage>().init();

  runApp(const StorageDemoApp());
}

class StorageDemoApp extends StatelessWidget {
  const StorageDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const StorageDemoPage());
  }
}

class StorageDemoPage extends StatefulWidget {
  const StorageDemoPage({super.key});

  @override
  State<StorageDemoPage> createState() => _StorageDemoPageState();
}

class _StorageDemoPageState extends State<StorageDemoPage> {
  String _value = '';

  void _test() async {
    await ServiceRegistry.get<IStorage>().putString('key', 'Hello Storage!');
    setState(() => _value = ServiceRegistry.get<IStorage>().getString('key'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storage Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('值: $_value'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _test, child: const Text('测试读写')),
          ],
        ),
      ),
    );
  }
}
