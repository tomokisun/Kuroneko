import Foundation

public enum InfoCategory: String, CaseIterable {
  case device = "Device"
  case application = "Application"
  case systemResource = "System Resource"
  case network = "Network"
  case locale = "Locale"
  case time = "Time"
  case ui = "UI/UX"
  
  public var items: [InfoItem] {
    switch self {
    case .device:
      return [.deviceModel, .deviceType, .deviceName, .systemName, .systemVersion]
    case .application:
      return [.appVersion, .appBuild, .bundleIdentifier, .appName]
    case .systemResource:
      return [.totalMemory, .availableMemory, .totalStorage, .availableStorage, .processorCount]
    case .network:
      return [.networkType, .carrierName]
    case .locale:
      return [.language, .region, .timezone, .locale]
    case .time:
      return [.currentTimestamp, .uptime]
    case .ui:
      return [.screenWidth, .screenHeight, .screenScale, .userInterfaceStyle]
    }
  }
}
