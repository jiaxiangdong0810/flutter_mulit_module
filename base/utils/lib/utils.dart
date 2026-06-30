/// 简单工具类
class AppUtils {
  /// 格式化时间为 yyyy-MM-dd HH:mm:ss
  static String formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${_pad(dateTime.month)}-${_pad(dateTime.day)} '
        '${_pad(dateTime.hour)}:${_pad(dateTime.minute)}:${_pad(dateTime.second)}';
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');

  /// 简单手机号校验
  static bool isValidPhone(String phone) {
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(phone);
  }
}
