.PHONY: dev build-logger build-storage build-all logger-sdk storage-sdk all-sdk

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
