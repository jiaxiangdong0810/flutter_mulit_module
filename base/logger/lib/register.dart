export 'logger_sdk.dart';

import 'ilog.dart';
import 'logger_sdk.dart';

/// 初始化日志服务并返回实例
/// 内部项目可将返回值注册到 ServiceRegistry
ILog initLogService() {
  Logger.init();
  return Logger.instance;
}
