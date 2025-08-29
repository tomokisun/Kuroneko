import UIKit

class DeviceInfoCollector {
  
  @MainActor
  func collect(items: Set<InfoItem>) -> [String: String] {
    var info: [String: String] = [:]
    let device = UIDevice.current
    
    if items.contains(.deviceModel) {
      info[InfoItem.deviceModel.rawValue] = getDeviceModel()
    }
    
    if items.contains(.deviceType) {
      info[InfoItem.deviceType.rawValue] = device.model
    }
    
    if items.contains(.deviceName) {
      info[InfoItem.deviceName.rawValue] = device.name
    }
    
    if items.contains(.systemName) {
      info[InfoItem.systemName.rawValue] = device.systemName
    }
    
    if items.contains(.systemVersion) {
      info[InfoItem.systemVersion.rawValue] = device.systemVersion
    }
    
    return info
  }
  
  private func getDeviceModel() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    return mapToDevice(identifier: identifier)
  }
  
  private func mapToDevice(identifier: String) -> String {
    // 実際のデバイスまたはシミュレータ
    if identifier == "i386" || identifier == "x86_64" || identifier == "arm64" {
      return ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "Simulator"
    }
    
    // よく使われるデバイスのマッピング（一部抜粋）
    let deviceMap: [String: String] = [
      // iPhone
      "iPhone15,4": "iPhone 15 Plus",
      "iPhone15,5": "iPhone 15",
      "iPhone15,2": "iPhone 15 Pro",
      "iPhone15,3": "iPhone 15 Pro Max",
      "iPhone14,2": "iPhone 13 Pro",
      "iPhone14,3": "iPhone 13 Pro Max",
      "iPhone14,4": "iPhone 13 mini",
      "iPhone14,5": "iPhone 13",
      "iPhone14,6": "iPhone SE (3rd gen)",
      "iPhone14,7": "iPhone 14",
      "iPhone14,8": "iPhone 14 Plus",
      "iPhone15,0": "iPhone 14 Pro",
      "iPhone15,1": "iPhone 14 Pro Max",
      
      // iPad
      "iPad13,1": "iPad Air (4th gen)",
      "iPad13,2": "iPad Air (4th gen)",
      "iPad13,4": "iPad Pro 11\" (3rd gen)",
      "iPad13,5": "iPad Pro 11\" (3rd gen)",
      "iPad13,8": "iPad Pro 12.9\" (5th gen)",
      "iPad13,9": "iPad Pro 12.9\" (5th gen)",
    ]
    
    return deviceMap[identifier] ?? identifier
  }
}
