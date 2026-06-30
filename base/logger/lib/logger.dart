import 'dart:developer' as developer;
import 'package:service/service.dart';

/// 日志服务实现
class AppLog implements ILog {
  static const String _defaultTag = 'App';

  @override
  void d(String message, {String tag = _defaultTag}) {
    developer.log(message, name: tag, level: 0);
  }

  @override
  void i(String message, {String tag = _defaultTag}) {
    developer.log(message, name: tag, level: 800);
  }

  @override
  void e(String message, {String tag = _defaultTag}) {
    developer.log(message, name: tag, level: 1000);
  }
}
