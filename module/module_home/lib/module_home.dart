import 'package:app_router/app_router.dart';
import 'package:module_registry/module_registry.dart';
import 'home_module.dart';
import 'home_page.dart';

export 'home_page.dart';

/// 注册 HomeModule
void registerHomeModule() {
  ModuleRegistry.register(const HomeModule());
  AppRouter.register('/home', (_) => const HomePage());
}
