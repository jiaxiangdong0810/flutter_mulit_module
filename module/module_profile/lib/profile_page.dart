import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';

class ProfilePage extends BasePage {
  const ProfilePage({super.key});

  @override
  String get title => '个人信息设置';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage> {
  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('昵称'),
          subtitle: Text('测试用户'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('邮箱'),
          subtitle: Text('test@example.com'),
        ),
      ],
    );
  }
}
