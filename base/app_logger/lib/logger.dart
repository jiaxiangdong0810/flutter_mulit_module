import 'dart:developer' as developer;
import 'package:logger/logger.dart' as ext;
import 'ilog.dart';

/// 日志服务实现
///
/// 同时输出到:
/// - Android Studio Run 面板 (dart:developer.log)
/// - Logcat / stdout (package:logger ConsoleOutput)
class AppLog implements ILog {
  static const String _defaultTag = 'App';

  /// package:logger 实例，输出到控制台（stdout → Logcat）
  static final ext.Logger _consoleLogger = ext.Logger(
    printer: ext.PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      noBoxingByDefault: true,
    ),
    output: ext.ConsoleOutput(),
    level: ext.Level.debug,
  );

  @override
  void d(String message, {String tag = _defaultTag}) {
    developer.log(message, name: tag, level: 0);
    _consoleLogger.d('[$tag] $message');
  }

  @override
  void i(String message, {String tag = _defaultTag}) {
    developer.log(message, name: tag, level: 800);
    _consoleLogger.i('[$tag] $message');
  }

  @override
  void e(String message, {String tag = _defaultTag}) {
    developer.log(message, name: tag, level: 1000);
    _consoleLogger.e('[$tag] $message');
  }
}
