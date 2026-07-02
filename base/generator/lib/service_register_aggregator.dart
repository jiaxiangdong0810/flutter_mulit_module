import 'dart:async';
import 'package:build/build.dart';

/// 此 Builder 不再使用，已改为 tool/gen_services.dart 脚本生成
/// 保留类定义以避免 build_runner 报错
class ServiceRegisterAggregator implements Builder {
  ServiceRegisterAggregator(BuilderOptions options);

  @override
  Map<String, List<String>> get buildExtensions => {};

  @override
  Future<void> build(BuildStep buildStep) async {
    // no-op
  }
}
