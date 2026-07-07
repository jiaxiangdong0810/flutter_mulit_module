import 'package:base_ui/base_ui.dart';

/// 模块注册表
/// =============================
/// 注册：ModuleRegistry.register(XxxModule())
/// 获取：ModuleRegistry.getHomeModule() / getMineModule() / ...
/// 未注册返回 null
/// =============================
class ModuleRegistry {
  static final Map<String, AppModule> _modules = {};

  /// 注册模块
  static void register(AppModule module) {
    _modules[module.id] = module;
  }

  static AppModule? getHomeModule() => _modules['home'];
  static AppModule? getMineModule() => _modules['mine'];
  static AppModule? getProfileModule() => _modules['profile'];
}
