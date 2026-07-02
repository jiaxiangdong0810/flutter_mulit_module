export 'storage_sdk.dart';

import 'istorage.dart';
import 'storage_sdk.dart';

/// 初始化存储服务并返回实例
/// 内部项目可将返回值注册到 ServiceRegistry
Future<IStorage> initStorageService() async {
  await Storage.init();
  return Storage.instance;
}
