import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:annotation/annotation.dart';

/// 扫描 @ServiceRegister 注解，生成注册代码
class ServiceRegisterGenerator extends GeneratorForAnnotation<ServiceRegister> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! FunctionElement) {
      throw InvalidGenerationSourceError(
        '@ServiceRegister 只能用在函数上',
        element: element,
      );
    }

    // 返回调用语句
    return '${element.name}();';
  }
}
