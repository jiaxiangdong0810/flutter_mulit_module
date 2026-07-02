/// Storage SDK 对外统一导出文件
///
/// 外部团队使用方式:
/// ```dart
/// import 'package:storage/storage_sdk.dart';
///
/// Storage.init();
/// Storage.putString('key', 'value');
/// final value = Storage.getString('key');
/// ```
library storage_sdk;

export 'istorage.dart';

import 'istorage.dart';
import 'storage.dart';

/// 存储工具 - 静态方法封装
class Storage {
  static IStorage _instance = NoopStorage();

  /// 获取当前存储实例
  static IStorage get instance => _instance;

  /// 使用默认 AppStorage 实现初始化
  static Future<void> init({IStorage? impl}) async {
    _instance = impl ?? AppStorage();
    await _instance.init();
  }

  /// 存储字符串
  static Future<void> putString(String key, String value) =>
      _instance.putString(key, value);

  /// 获取字符串
  static String getString(String key, {String defaultValue = ''}) =>
      _instance.getString(key, defaultValue: defaultValue);

  /// 存储整数
  static Future<void> putInt(String key, int value) =>
      _instance.putInt(key, value);

  /// 获取整数
  static int getInt(String key, {int defaultValue = 0}) =>
      _instance.getInt(key, defaultValue: defaultValue);

  /// 存储布尔值
  static Future<void> putBool(String key, bool value) =>
      _instance.putBool(key, value);

  /// 获取布尔值
  static bool getBool(String key, {bool defaultValue = false}) =>
      _instance.getBool(key, defaultValue: defaultValue);

  /// 删除
  static Future<void> remove(String key) => _instance.remove(key);
}
