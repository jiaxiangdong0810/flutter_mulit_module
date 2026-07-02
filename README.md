# Flutter 多模块组件化架构

一个支持**组件化开发**和**动态切换 SDK/源码依赖**的 Flutter 项目。

## 项目结构

```
FlutterMulitModule/
├── base/                          # 基础组件层
│   ├── logger/                    # 日志组件（自包含 SDK）
│   ├── service/                   # 服务注册表（接口中转）
│   ├── storage/                   # 存储组件（自包含 SDK）
│   └── utils/                     # 工具类
├── common/                        # 公共业务层
│   └── base_ui/                   # 公共 UI 组件
├── module/                        # 业务模块层
│   ├── module_home/               # 首页模块
│   └── module_mine/               # 我的模块
├── packages/                      # SDK 构建产物（gitignore）
├── tool/                          # 构建工具
│   ├── build_sdk.dart             # SDK 构建脚本
│   └── switch_deps.dart           # 依赖切换脚本
├── lib/
│   └── main.dart                  # 应用入口
└── Makefile                       # 快捷命令
```

## 架构设计

### 三层架构

```
┌─────────────────────────────────────────────┐
│              业务模块层 (module)              │
│   module_home    module_mine    ...         │
├─────────────────────────────────────────────┤
│            公共业务层 (common)                │
│                 base_ui                      │
├─────────────────────────────────────────────┤
│             基础组件层 (base)                 │
│   logger    service    storage    utils     │
└─────────────────────────────────────────────┘
```

### 组件化核心：ServiceRegistry

`service` 包提供全局服务注册表，实现依赖反转：

```dart
// 服务注册表 - 全局服务定位器
class ServiceRegistry {
  static final Map<Type, dynamic> _impls = {};

  static void register<T>(T impl) => _impls[T] = impl;
  static T get<T>() => _impls[T] ?? _noop<T>();
}
```

业务模块通过 `ServiceRegistry.get<T>()` 获取服务，不直接依赖具体实现：

```dart
// module_home 中使用日志
ServiceRegistry.get<ILog>().i('Hello', tag: 'Home');
```

### 自包含组件设计

每个基础组件都是**自包含**的，内置接口定义：

```
base/logger/
├── lib/
│   ├── ilog.dart          # 接口定义（ILog + NoopLog）
│   ├── logger.dart        # 实现类（AppLog）
│   ├── logger_sdk.dart    # SDK 导出（Logger 静态方法）
│   └── register.dart      # 初始化入口
└── pubspec.yaml           # 无外部依赖
```

**接口内聚**：组件自己定义接口，不依赖外部包。

**双重使用方式**：
- 内部项目：通过 `ServiceRegistry.get<ILog>()` 调用
- 外部团队：通过 `Logger.d()` 静态方法调用

## 快速开始

### 安装依赖

```bash
flutter pub get
```

### 运行项目

```bash
flutter run
```

## 组件独立运行

每个组件都有 `onlyRun/main.dart`，可以独立运行和调试：

```bash
# 独立运行 logger 组件
cd base/logger && dart onlyRun/main.dart

# 独立运行 storage 组件
cd base/storage && dart onlyRun/main.dart
```

## 动态切换 SDK / 源码

支持**按组件**切换依赖方式，方便开发调试和版本管理。

### 命令一览

```bash
make dev            # 全部使用源码（默认）
make logger-sdk     # logger 使用 SDK，其他用源码
make storage-sdk    # storage 使用 SDK，其他用源码
make all-sdk        # 全部使用 SDK
```

### 工作原理

通过 Dart 的 `dependency_overrides` 机制实现：

```yaml
# pubspec.yaml（make logger-sdk 后自动生成）
dependency_overrides:
  logger:
    path: packages/logger    # 指向 SDK 构建产物

dependencies:
  logger:
    path: base/logger        # 原始源码（被 override）
```

`make dev` 会移除 `dependency_overrides`，恢复源码依赖。

### 使用场景

| 场景 | 命令 | 说明 |
|------|------|------|
| 日常开发 | `make dev` | 直接改源码，即时生效 |
| 调试某个组件 | `make dev` | 使用源码，可以断点调试 |
| 锁定版本 | `make logger-sdk` | 使用稳定 SDK，避免意外改动 |
| 给其他团队 | `make build-all` | 构建 SDK 到 `packages/` |

## 外部团队使用

### 方式一：直接引用源码

```yaml
# pubspec.yaml
dependencies:
  logger:
    path: /path/to/FlutterMulitModule/base/logger
  storage:
    path: /path/to/FlutterMulitModule/base/storage
```

### 方式二：使用构建的 SDK

```bash
# 先构建 SDK
make build-all

# 拿 packages/ 目录给其他团队
```

```yaml
# 其他团队的 pubspec.yaml
dependencies:
  logger:
    path: /path/to/packages/logger
  storage:
    path: /path/to/packages/storage
```

### SDK 使用示例

```dart
import 'package:logger/logger_sdk.dart';
import 'package:storage/storage_sdk.dart';

// 初始化
Logger.init();
await Storage.init();

// 使用
Logger.d('Debug message');
Logger.i('Info message', tag: 'MyModule');
Logger.e('Error message');

await Storage.putString('key', 'value');
final value = Storage.getString('key');
```

## 添加新组件

### 1. 创建组件目录

```bash
mkdir -p base/my_component/lib
```

### 2. 创建接口 `base/my_component/lib/imy_component.dart`

```dart
abstract class IMyComponent {
  void doSomething();
}

class NoopMyComponent implements IMyComponent {
  @override
  void doSomething() {}
}
```

### 3. 创建实现 `base/my_component/lib/my_component.dart`

```dart
import 'imy_component.dart';

class AppMyComponent implements IMyComponent {
  @override
  void doSomething() {
    // 实现逻辑
  }
}
```

### 4. 创建 SDK 导出 `base/my_component/lib/my_component_sdk.dart`

```dart
export 'imy_component.dart';
import 'imy_component.dart';
import 'my_component.dart';

class MyComponent {
  static IMyComponent _instance = NoopMyComponent();
  static IMyComponent get instance => _instance;

  static void init({IMyComponent? impl}) {
    _instance = impl ?? AppMyComponent();
  }

  static void doSomething() => _instance.doSomething();
}
```

### 5. 创建注册入口 `base/my_component/lib/register.dart`

```dart
export 'my_component_sdk.dart';
import 'imy_component.dart';
import 'my_component_sdk.dart';

IMyComponent initMyComponentService() {
  MyComponent.init();
  return MyComponent.instance;
}
```

### 6. 创建 pubspec.yaml

```yaml
name: my_component
description: "My component description."
version: 1.0.0
publish_to: 'none'

environment:
  sdk: ^3.5.0

dependencies:
```

### 7. 在主项目中注册

```dart
// lib/main.dart
import 'package:my_component/register.dart';

void main() async {
  // ...
  ServiceRegistry.register<IMyComponent>(initMyComponentService());
  // ...
}
```

### 8. 添加到主项目依赖

```yaml
# pubspec.yaml
dependencies:
  my_component:
    path: base/my_component
```

### 9. 更新构建脚本（可选）

```dart
// tool/build_sdk.dart
final components = target == 'all'
    ? ['logger', 'storage', 'my_component']  // 添加新组件
    : [target];
```

## 常见问题

### Q: 为什么组件要自包含？

A: 让每个组件可以独立分发，外部团队只需依赖一个包，不需要引入整个项目的基础层。

### Q: ServiceRegistry 和 Logger.init() 什么关系？

A:
- `ServiceRegistry` 是内部项目的服务定位器，模块间解耦用
- `Logger.init()` 是 SDK 对外 API，外部团队用
- 内部项目两者都用：先 `Logger.init()`，再注册到 `ServiceRegistry`

### Q: dependency_overrides 会影响其他包吗？

A: 只覆盖指定的包，其他包的依赖关系不变。

### Q: packages/ 目录需要提交到 Git 吗？

A: 不需要，已在 `.gitignore` 中排除。需要给其他团队时，用 `make build-all` 重新构建。
