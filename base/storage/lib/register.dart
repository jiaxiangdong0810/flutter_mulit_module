import 'package:service/service.dart';
import 'storage.dart';

/// 存储服务注册入口
void registerStorageService() {
  ServiceRegistry.register<IStorage>(AppStorage());
}
