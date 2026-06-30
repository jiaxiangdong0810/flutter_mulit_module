import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:service/service.dart';

class MinePage extends BasePage {
  const MinePage({super.key});

  @override
  String get title => '我的';

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends BasePageState<MinePage> {
  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('测试用户'),
          accountEmail: Text('test@example.com'),
          currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('设置'),
          onTap: () {
            ServiceRegistry.get<ILog>().i('点击设置', tag: 'Mine');
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('关于'),
          onTap: () {
            BaseDialog.showConfirm(
              context,
              title: '关于',
              content: 'Flutter 多模块组件化验证 Demo',
            );
          },
        ),
      ],
    );
  }
}
