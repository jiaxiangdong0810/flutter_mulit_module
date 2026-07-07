/// 日志服务接口
abstract class ILog {
  void d(String message, {String tag});
  void i(String message, {String tag});
  void e(String message, {String tag});
}

/// 空实现 - 未初始化时使用
class NoopLog implements ILog {
  @override
  void d(String message, {String tag = ''}) {}

  @override
  void i(String message, {String tag = ''}) {}

  @override
  void e(String message, {String tag = ''}) {}
}
