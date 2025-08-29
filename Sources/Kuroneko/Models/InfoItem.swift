import Foundation

public enum InfoItem: String, CaseIterable {
  // Device
  case deviceModel = "device_model"
  case deviceType = "device_type"
  case deviceName = "device_name"
  case systemName = "system_name"
  case systemVersion = "system_version"
  
  // Application
  case appVersion = "app_version"
  case appBuild = "app_build"
  case bundleIdentifier = "bundle_identifier"
  case appName = "app_name"
  
  // System Resource
  case totalMemory = "total_memory"
  case availableMemory = "available_memory"
  case totalStorage = "total_storage"
  case availableStorage = "available_storage"
  case processorCount = "processor_count"
  
  // Network
  case networkType = "network_type"
  case carrierName = "carrier_name"
  
  // Locale
  case language = "language"
  case region = "region"
  case timezone = "timezone"
  case locale = "locale"
  
  // Time
  case currentTimestamp = "current_timestamp"
  case uptime = "uptime"
  
  // UI/UX
  case screenWidth = "screen_width"
  case screenHeight = "screen_height"
  case screenScale = "screen_scale"
  case userInterfaceStyle = "user_interface_style"
  
  
  public var category: InfoCategory {
    switch self {
    case .deviceModel, .deviceType, .deviceName, .systemName, .systemVersion:
      return .device
    case .appVersion, .appBuild, .bundleIdentifier, .appName:
      return .application
    case .totalMemory, .availableMemory, .totalStorage, .availableStorage, .processorCount:
      return .systemResource
    case .networkType, .carrierName:
      return .network
    case .language, .region, .timezone, .locale:
      return .locale
    case .currentTimestamp, .uptime:
      return .time
    case .screenWidth, .screenHeight, .screenScale, .userInterfaceStyle:
      return .ui
    }
  }
}
