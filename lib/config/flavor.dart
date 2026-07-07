/// 应用风味配置
/// 通过 --dart-define=FLAVOR=prod 或 beta 来区分不同应用
enum Flavor {
  prod,
  beta;

  static Flavor get current {
    const flavorName = String.fromEnvironment('FLAVOR', defaultValue: 'prod');
    return Flavor.values.firstWhere(
      (f) => f.name == flavorName,
      orElse: () => Flavor.prod,
    );
  }

  /// 应用显示名称
  String get appName {
    switch (this) {
      case Flavor.prod:
        return 'Flutter多模块';
      case Flavor.beta:
        return 'Flutter多模块Beta';
    }
  }

  /// 是否为体验版
  bool get isBeta => this == Flavor.beta;
}
