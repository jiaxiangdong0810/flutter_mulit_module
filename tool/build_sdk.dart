// ignore_for_file: avoid_print
import 'dart:io';

/// 构建 SDK
///
/// 用法:
///   dart tool/build_sdk.dart logger   # 构建 logger SDK
///   dart tool/build_sdk.dart storage  # 构建 storage SDK
///   dart tool/build_sdk.dart all      # 构建全部
void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart tool/build_sdk.dart [logger|storage|all]');
    exit(1);
  }

  final target = args[0];
  final components = target == 'all'
      ? ['logger', 'storage']
      : [target];

  for (final name in components) {
    _buildSdk(name);
  }
}

void _buildSdk(String name) {
  final sourceDir = Directory('base/$name');
  final outputDir = Directory('packages/$name');

  if (!sourceDir.existsSync()) {
    print('Error: ${sourceDir.path} not found.');
    exit(1);
  }

  // 清理并创建输出目录
  if (outputDir.existsSync()) {
    outputDir.deleteSync(recursive: true);
  }
  outputDir.createSync(recursive: true);

  // 复制 lib 目录
  _copyDirectory(
    Directory('${sourceDir.path}/lib'),
    Directory('${outputDir.path}/lib'),
  );

  // 复制 pubspec.yaml
  File('${sourceDir.path}/pubspec.yaml')
      .copySync('${outputDir.path}/pubspec.yaml');

  // 复制 README（如果存在）
  final readme = File('${sourceDir.path}/README.md');
  if (readme.existsSync()) {
    readme.copySync('${outputDir.path}/README.md');
  }

  print('✅ Built: ${outputDir.path}');
}

void _copyDirectory(Directory source, Directory destination) {
  destination.createSync(recursive: true);
  for (final entity in source.listSync()) {
    final name = entity.path.split('/').last;
    if (entity is File) {
      entity.copySync('${destination.path}/$name');
    } else if (entity is Directory) {
      _copyDirectory(entity, Directory('${destination.path}/$name'));
    }
  }
}
