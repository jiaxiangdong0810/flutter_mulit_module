import 'package:service/service.dart';
import 'package:logger/logger.dart';

/// logger 组件独立运行
void main() {
  // 注册日志服务
  ServiceRegistry.register<ILog>(AppLog());

  final log = ServiceRegistry.get<ILog>();
  log.d('Debug 日志');
  log.i('Info 日志');
  log.e('Error 日志');
  log.d('自定义 Tag', tag: 'MyTag');
}
