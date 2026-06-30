import 'ilog.dart';
import 'istorage.dart';

/// 服务注册表 - 全局服务定位器
class ServiceRegistry {
  static final Map<Type, dynamic> _impls = {};

  /// 注册服务实现
  static void register<T>(T impl) {
    _impls[T] = impl;
  }

  /// 获取服务实例，未注册则返回空实现
  static T get<T>() {
    final impl = _impls[T];
    if (impl != null) return impl as T;
    return _noop<T>();
  }

  /// 注销服务
  static void unregister<T>() {
    _impls.remove(T);
  }

  /// 获取空实现
  static T _noop<T>() {
    if (T == ILog) return NoopLog() as T;
    if (T == IStorage) return NoopStorage() as T;
    throw Exception('未找到服务 $T 的空实现，请先注册');
  }
}
