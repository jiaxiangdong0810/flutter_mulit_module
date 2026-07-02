import 'package:build/build.dart';
import 'service_register_aggregator.dart';

/// Builder 工厂函数，供 build_runner 使用
/// 扫描所有 @serviceRegister 注解，生成 services.g.dart
Builder serviceRegisterBuilder(BuilderOptions options) =>
    ServiceRegisterAggregator(options);
