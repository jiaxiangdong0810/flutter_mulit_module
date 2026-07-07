import 'package:shared_preferences/shared_preferences.dart';
import 'istorage.dart';

/// 存储服务实现
class AppStorage implements IStorage {
  static late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> putString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  @override
  Future<void> putInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  @override
  Future<void> putBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
