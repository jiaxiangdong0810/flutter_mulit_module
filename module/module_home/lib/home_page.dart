import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:service/service.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  String get title => '主页';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = ServiceRegistry.get<IStorage>().getInt('counter');
  }

  void _increment() {
    setState(() {
      _counter++;
    });
    ServiceRegistry.get<IStorage>().putInt('counter', _counter);
    ServiceRegistry.get<ILog>().i('counter saved: $_counter', tag: 'Home');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('日志已打印: counter saved: $_counter'), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('计数器: $_counter', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _increment,
            child: const Text('点击 +1（数据持久化）'),
          ),
        ],
      ),
    );
  }
}
