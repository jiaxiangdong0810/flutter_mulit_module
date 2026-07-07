/// 存储服务接口
abstract class IStorage {
  Future<void> init();
  Future<void> putString(String key, String value);
  String getString(String key, {String defaultValue});
  Future<void> putInt(String key, int value);
  int getInt(String key, {int defaultValue});
  Future<void> putBool(String key, bool value);
  bool getBool(String key, {bool defaultValue});
  Future<void> remove(String key);
}

/// 空实现 - 未初始化时使用
class NoopStorage implements IStorage {
  @override
  Future<void> init() async {}

  @override
  Future<void> putString(String key, String value) async {}

  @override
  String getString(String key, {String defaultValue = ''}) => defaultValue;

  @override
  Future<void> putInt(String key, int value) async {}

  @override
  int getInt(String key, {int defaultValue = 0}) => defaultValue;

  @override
  Future<void> putBool(String key, bool value) async {}

  @override
  bool getBool(String key, {bool defaultValue = false}) => defaultValue;

  @override
  Future<void> remove(String key) async {}
}
