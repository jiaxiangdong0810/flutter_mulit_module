import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'service_register_generator.dart';

/// Builder 工厂函数
Builder serviceRegisterBuilder(BuilderOptions options) =>
    PartBuilder([ServiceRegisterGenerator()], '.register.g');
