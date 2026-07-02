/// 服务注册注解
/// 标记在注册函数上，build_runner 会自动收集并生成 registerAllServices()
class ServiceRegister {
  const ServiceRegister();
}

/// 常量实例，方便使用
const serviceRegister = ServiceRegister();
