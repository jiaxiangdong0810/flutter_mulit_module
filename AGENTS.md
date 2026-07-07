# AGENTS.md

本项目重点是 Flutter 多模块架构验证。AI 改代码时优先保护架构边界，少写代码，少加依赖。

## 项目边界

- `lib/` 是宿主 App：负责启动、Flavor、服务初始化和页面组装。
- `base/` 是基础能力层：`service` 只做接口中转和注册表；`logger`、`storage` 等组件要能独立运行、独立导出 SDK。
- `common/` 是公共业务层：放可复用 UI/业务基础件，可以依赖 `base/service`。
- `module/` 是业务模块层：模块之间不要互相依赖，只依赖 `common` 和 `base/service`。
- `packages/` 是 SDK 构建产物，不要手改。

## 依赖规则

- 业务模块获取能力必须走 `ServiceRegistry.get<T>()`，不要直接依赖 `logger`、`storage` 的实现类。
- 具体服务只在宿主入口或组件 `register.dart` 初始化并注册。
- 新增基础组件时，优先沿用现有模式：`i*.dart` 接口、实现类、`*_sdk.dart` 外部 SDK、`register.dart` 内部注册入口、`onlyRun/main.dart` 独立验证。
- 不要引入新的状态管理、路由、DI、代码生成或脚手架，除非用户明确要求并说明收益。
- 不要为了“以后可能用”新增抽象、配置层或跨模块公共包。

## 修改原则

- 先看已有模式，再做最小改动；能复用现有包和 Flutter/Dart 标准能力就不要新增依赖。
- 保持组件自包含：基础组件对外提供 SDK 用法，对内通过接口接入 `ServiceRegistry`。
- 可选功能必须有兜底：远程配置失败、未知功能 id、服务未注册或功能不可用时，只隐藏/降级该功能，不能影响 App 启动和默认页面。
- 壳 App 只能信任本地默认功能；远程配置只能改变可见性、顺序和灰度，不能决定 App 是否可运行。
- 改依赖切换逻辑时，同步检查 `Makefile`、根 `pubspec.yaml`、`tool/switch_deps.dart`。
- 改 Flavor 或平台配置时，同步检查 Android flavor、iOS scheme/xcconfig、`lib/config/flavor.dart`。
- 不要改生成目录：`.dart_tool/`、`build/`、平台临时产物。

## 常用检查

- 安装依赖：`flutter pub get`
- 静态检查：`flutter analyze`
- 测试：`flutter test`
- 源码依赖模式：`make dev`
- SDK 依赖模式：`make logger-sdk`、`make storage-sdk`、`make all-sdk`

## 输出要求

- 提交前说明改了哪些架构点，以及有没有新增依赖或破坏模块边界。
- 如果没有运行检查，要明确说明原因。
