import 'package:flutter/material.dart';
import 'package:service/service.dart';
import 'package:app_logger/logger.dart';
import 'package:base_ui/base_ui.dart';

/// base_ui 组件独立运行
void main() {
  // 注册日志服务（BasePage 需要）
  ServiceRegistry.register<ILog>(AppLog());

  runApp(const BaseUIDemoApp());
}

class BaseUIDemoApp extends StatelessWidget {
  const BaseUIDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const DemoPage());
  }
}

class DemoPage extends BasePage {
  const DemoPage({super.key});

  @override
  String get title => 'BaseUI Demo';

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends BasePageState<DemoPage> {
  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('这是使用 BasePage 的示例'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              BaseDialog.showConfirm(
                context,
                title: '提示',
                content: '这是一个确认弹窗',
              );
            },
            child: const Text('显示弹窗'),
          ),
        ],
      ),
    );
  }
}
