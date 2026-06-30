import 'package:service/service.dart';

void main() {
  // 测试未注册时的空实现
  final log = ServiceRegistry.get<ILog>();
  log.d('这是一条调试日志');
  log.i('这是一条信息日志');
  log.e('这是一条错误日志');

  print('---');

  // 测试注册后
  ServiceRegistry.register<ILog>(MyLog());
  final log2 = ServiceRegistry.get<ILog>();
  log2.d('注册后的调试日志');
  log2.i('注册后的信息日志');
}

/// 自定义日志实现
class MyLog implements ILog {
  @override
  void d(String message, {String tag = ''}) => print('[DEBUG] $tag: $message');

  @override
  void i(String message, {String tag = ''}) => print('[INFO] $tag: $message');

  @override
  void e(String message, {String tag = ''}) => print('[ERROR] $tag: $message');
}
