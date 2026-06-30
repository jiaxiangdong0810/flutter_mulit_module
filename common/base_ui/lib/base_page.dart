import 'package:flutter/material.dart';
import 'package:service/service.dart';

/// 基础页面，封装通用 AppBar 和 body 结构
abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});

  String get title;

  @override
  State<BasePage> createState();
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  @override
  void initState() {
    super.initState();
    ServiceRegistry.get<ILog>().d('${widget.title}.initState', tag: 'Page');
  }

  @override
  void dispose() {
    ServiceRegistry.get<ILog>().d('${widget.title}.dispose', tag: 'Page');
    super.dispose();
  }

  /// 子类实现页面内容
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: buildBody(context),
    );
  }
}
