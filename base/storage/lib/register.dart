import 'package:service/service.dart';
import 'package:annotation/annotation.dart';
import 'storage.dart';

/// 存储服务注册入口
/// @serviceRegister 注解标记，等 build_runner 配置好后可自动生成
@serviceRegister
void registerStorageService() {
  ServiceRegistry.register<IStorage>(AppStorage());
}
