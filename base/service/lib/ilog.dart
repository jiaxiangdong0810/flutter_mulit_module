/// 日志服务接口
abstract class ILog {
  void d(String message, {String tag});
  void i(String message, {String tag});
  void e(String message, {String tag});
}

/// 空实现 - 未注册时使用
class NoopLog implements ILog {
  @override
  void d(String message, {String tag = ''}) => print('⚠️ 日志功能未注册: $message');

  @override
  void i(String message, {String tag = ''}) => print('⚠️ 日志功能未注册: $message');

  @override
  void e(String message, {String tag = ''}) => print('⚠️ 日志功能未注册: $message');
}
