import 'package:app_router/app_router.dart';
import 'package:module_registry/module_registry.dart';
import 'profile_module.dart';
import 'profile_page.dart';

export 'profile_page.dart';

/// 注册 ProfileModule
void registerProfileModule() {
  ModuleRegistry.register(const ProfileModule());
  AppRouter.register('/profile', (_) => const ProfilePage());
}
