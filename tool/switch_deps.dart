// ignore_for_file: avoid_print
import 'dart:io';

/// 切换依赖模式
///
/// 用法:
///   dart tool/switch_deps.dart dev              # 全部使用源码
///   dart tool/switch_deps.dart logger-sdk       # app_logger 使用 SDK
///   dart tool/switch_deps.dart storage-sdk      # storage 使用 SDK
///   dart tool/switch_deps.dart all-sdk          # 全部使用 SDK
void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart tool/switch_deps.dart [dev|app_logger-sdk|storage-sdk|all-sdk]');
    exit(1);
  }

  final mode = args[0];
  final pubspecFile = File('pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    print('Error: pubspec.yaml not found.');
    exit(1);
  }

  var content = pubspecFile.readAsStringSync();

  // 移除已有的 dependency_overrides 块
  content = _removeDependencyOverrides(content);

  switch (mode) {
    case 'dev':
      print('✅ 源码模式');
      break;
    case 'logger-sdk':
      content = _addOverrides(content, ['app_logger']);
      print('✅ app_logger 使用 SDK');
      break;
    case 'storage-sdk':
      content = _addOverrides(content, ['storage']);
      print('✅ storage 使用 SDK');
      break;
    case 'all-sdk':
      content = _addOverrides(content, ['app_logger', 'storage']);
      print('✅ 全部使用 SDK');
      break;
    default:
      print('Unknown mode: $mode');
      exit(1);
  }

  pubspecFile.writeAsStringSync(content);
}

String _removeDependencyOverrides(String content) {
  final lines = content.split('\n');
  final result = <String>[];
  var skip = false;

  for (final line in lines) {
    if (line.startsWith('dependency_overrides:')) {
      skip = true;
      continue;
    }
    if (skip) {
      if (line.isNotEmpty && !line.startsWith(' ') && line.endsWith(':')) {
        skip = false;
      } else {
        continue;
      }
    }
    result.add(line);
  }

  return result.join('\n');
}

String _addOverrides(String content, List<String> packages) {
  final buffer = StringBuffer();
  buffer.writeln('dependency_overrides:');
  for (final pkg in packages) {
    buffer.writeln('  $pkg:');
    buffer.writeln('    path: packages/$pkg');
  }
  buffer.writeln();

  // 在 dependencies 前插入
  return content.replaceFirst('dependencies:', '${buffer}dependencies:');
}
