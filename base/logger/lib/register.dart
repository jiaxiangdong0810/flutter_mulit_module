import 'package:service/service.dart';
import 'logger.dart';

/// 日志服务注册入口
/// 当移除 logger 包时，只需在 services.dart 中注释掉 import 这个文件
void registerLogService() {
  ServiceRegistry.register<ILog>(AppLog());
}
