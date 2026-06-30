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

/// 空实现 - 未注册时使用
class NoopStorage implements IStorage {
  @override
  Future<void> init() async {}

  @override
  Future<void> putString(String key, String value) async =>
      print('⚠️ 存储功能未注册: putString($key)');

  @override
  String getString(String key, {String defaultValue = ''}) {
    print('⚠️ 存储功能未注册: getString($key)');
    return defaultValue;
  }

  @override
  Future<void> putInt(String key, int value) async =>
      print('⚠️ 存储功能未注册: putInt($key)');

  @override
  int getInt(String key, {int defaultValue = 0}) {
    print('⚠️ 存储功能未注册: getInt($key)');
    return defaultValue;
  }

  @override
  Future<void> putBool(String key, bool value) async =>
      print('⚠️ 存储功能未注册: putBool($key)');

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    print('⚠️ 存储功能未注册: getBool($key)');
    return defaultValue;
  }

  @override
  Future<void> remove(String key) async =>
      print('⚠️ 存储功能未注册: remove($key)');
}
