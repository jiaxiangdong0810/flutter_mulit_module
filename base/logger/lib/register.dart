import 'package:service/service.dart';
import 'package:annotation/annotation.dart';
import 'logger.dart';

/// 日志服务注册入口
/// @serviceRegister 注解标记，等 build_runner 配置好后可自动生成
@serviceRegister
void registerLogService() {
  ServiceRegistry.register<ILog>(AppLog());
}
