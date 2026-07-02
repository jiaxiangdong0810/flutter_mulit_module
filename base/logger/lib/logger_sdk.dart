/// Logger SDK 对外统一导出文件
///
/// 外部团队使用方式:
/// ```dart
/// import 'package:logger/logger_sdk.dart';
///
/// Logger.init(); // 使用默认实现
/// Logger.d('debug message');
/// Logger.i('info message');
/// Logger.e('error message');
/// ```
library logger_sdk;

export 'ilog.dart';

import 'ilog.dart';
import 'logger.dart';

/// 日志工具 - 静态方法封装
class Logger {
  static ILog _instance = NoopLog();

  /// 获取当前日志实例
  static ILog get instance => _instance;

  /// 使用默认 AppLog 实现初始化
  static void init({ILog? impl}) {
    _instance = impl ?? AppLog();
  }

  /// Debug 日志
  static void d(String message, {String tag = 'App'}) {
    _instance.d(message, tag: tag);
  }

  /// Info 日志
  static void i(String message, {String tag = 'App'}) {
    _instance.i(message, tag: tag);
  }

  /// Error 日志
  static void e(String message, {String tag = 'App'}) {
    _instance.e(message, tag: tag);
  }
}
