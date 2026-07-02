.PHONY: dev build-logger build-storage build-all logger-sdk storage-sdk all-sdk run-prod run-beta build-apk-prod build-apk-beta build-ios-prod build-ios-beta

# 构建 SDK
build-logger:
	dart tool/build_sdk.dart logger

build-storage:
	dart tool/build_sdk.dart storage

build-all:
	dart tool/build_sdk.dart all

# 默认：使用源码
dev:
	dart tool/switch_deps.dart dev
	flutter pub get

# 切换 logger 为 SDK
logger-sdk: build-logger
	dart tool/switch_deps.dart logger-sdk
	flutter pub get

# 切换 storage 为 SDK
storage-sdk: build-storage
	dart tool/switch_deps.dart storage-sdk
	flutter pub get

# 全部切换为 SDK
all-sdk: build-all
	dart tool/switch_deps.dart all-sdk
	flutter pub get

# ========== 多 App 构建命令 ==========

# 运行正式版
run-prod:
	flutter run --flavor prod --dart-define=FLAVOR=prod

# 运行体验版
run-beta:
	flutter run --flavor beta --dart-define=FLAVOR=beta

# 构建正式版 APK
build-apk-prod:
	flutter build apk --flavor prod --dart-define=FLAVOR=prod

# 构建体验版 APK
build-apk-beta:
	flutter build apk --flavor beta --dart-define=FLAVOR=beta

# 构建正式版 iOS
build-ios-prod:
	flutter build ios --flavor prod --dart-define=FLAVOR=prod

# 构建体验版 iOS
build-ios-beta:
	flutter build ios --flavor beta --dart-define=FLAVOR=beta
