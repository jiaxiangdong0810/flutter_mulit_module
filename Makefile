.PHONY: setup build

# 增删组件后执行：make setup
setup:
	flutter pub get
	dart tool/gen_services.dart .

# 快捷别名
build: setup
