import 'package:logger/register.dart';
import 'package:storage/register.dart';

/// 服务配置文件
/// 在这里集中管理所有服务的注册
/// 想移除某个服务？注释掉对应的 import 和调用即可
void registerAllServices() {
  // 日志服务 - 注释下面这行即可移除日志功能
  registerLogService();

  // 存储服务 - 注释下面这行即可移除存储功能
  registerStorageService();
}
