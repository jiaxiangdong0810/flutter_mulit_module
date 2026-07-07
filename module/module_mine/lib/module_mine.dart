import 'package:app_router/app_router.dart';
import 'package:module_registry/module_registry.dart';
import 'mine_module.dart';
import 'mine_page.dart';

export 'mine_page.dart';

/// 注册 MineModule
void registerMineModule() {
  ModuleRegistry.register(const MineModule());
  AppRouter.register('/mine', (_) => const MinePage());
}
