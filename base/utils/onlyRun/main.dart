import 'package:utils/utils.dart';

/// utils 组件独立运行
void main() {
  print('时间: ${AppUtils.formatDateTime(DateTime.now())}');
  print('13800138000 有效: ${AppUtils.isValidPhone('13800138000')}');
  print('12345678901 有效: ${AppUtils.isValidPhone('12345678901')}');
}
