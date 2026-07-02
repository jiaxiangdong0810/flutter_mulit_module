// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

/// 自动扫描所有已引用的包，生成 services.g.dart
///
/// 原理：读取 .dart_tool/package_config.json 获取所有包路径，
/// 检查每个包是否有 lib/register.dart 且包含 @serviceRegister 注解，
/// 有则生成对应的 import 和函数调用。
///
/// 如果某个组件从 pubspec.yaml 中移除，其包路径不在 package_config 中，
/// 自动不会出现在生成的代码里。主应用通过 ServiceRegistry.get<T>() 获取服务，
/// 未注册的服务返回 Noop 空实现，不会报错。
void main(List<String> args) {
  final projectRoot = args.isNotEmpty ? args[0] : '.';
  final configPath = '$projectRoot/.dart_tool/package_config.json';

  final configFile = File(configPath);
  if (!configFile.existsSync()) {
    print('Error: $configPath not found. Run "flutter pub get" first.');
    exit(1);
  }

  final config = jsonDecode(configFile.readAsStringSync()) as Map<String, dynamic>;
  final packages = config['packages'] as List<dynamic>;

  final entries = <_RegisterEntry>[];

  for (final pkg in packages) {
    final name = pkg['name'] as String;
    final rootUri = pkg['rootUri'] as String;
    final packageUri = pkg['packageUri'] as String? ?? 'lib/';

    // 解析包的 lib 目录路径
    final libDir = _resolvePath(projectRoot, rootUri, packageUri);
    final registerFile = File('$libDir/register.dart');

    if (!registerFile.existsSync()) continue;

    final content = registerFile.readAsStringSync();
    if (!content.contains('@serviceRegister')) continue;

    // 提取函数名
    final match = RegExp(r'void\s+(\w+)\s*\(').firstMatch(content);
    if (match == null) continue;

    final funcName = match.group(1)!;
    entries.add(_RegisterEntry(
      package: name,
      funcName: funcName,
    ));
    print('  Found: $name -> $funcName()');
  }

  // 生成 services.g.dart
  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// 由 tool/gen_services.dart 自动生成');
  buffer.writeln('// 如果某个组件未引用，对应的注册调用不会出现');
  buffer.writeln();

  for (final entry in entries) {
    buffer.writeln("import 'package:${entry.package}/register.dart';");
  }

  buffer.writeln();
  buffer.writeln('/// 自动注册所有已引用组件的服务');
  buffer.writeln('void registerAllServices() {');
  for (final entry in entries) {
    buffer.writeln('  ${entry.funcName}();');
  }
  buffer.writeln('}');

  final outputPath = '$projectRoot/lib/services.g.dart';
  File(outputPath).writeAsStringSync(buffer.toString());
  print('Generated: $outputPath (${entries.length} services)');
}

/// 解析包路径为文件系统绝对路径
/// rootUri 是相对于 .dart_tool/ 目录的
String _resolvePath(String projectRoot, String rootUri, String packageUri) {
  if (rootUri.startsWith('file://')) {
    // 绝对路径
    final base = Uri.parse(rootUri).toFilePath();
    return '$base/$packageUri';
  } else {
    // 相对路径（相对于 .dart_tool/ 目录）
    final dartToolDir = '$projectRoot/.dart_tool';
    final base = _normalize('$dartToolDir/$rootUri');
    return '$base/$packageUri';
  }
}

/// 规范化路径，解析 . 和 ..
String _normalize(String path) {
  final segments = path.split('/');
  final normalized = <String>[];
  for (final seg in segments) {
    if (seg == '.' || seg.isEmpty) continue;
    if (seg == '..') {
      if (normalized.isNotEmpty) normalized.removeLast();
    } else {
      normalized.add(seg);
    }
  }
  return normalized.join('/');
}

class _RegisterEntry {
  final String package;
  final String funcName;

  _RegisterEntry({required this.package, required this.funcName});
}
