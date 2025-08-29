import Foundation

class ApplicationInfoCollector {
  
  func collect(items: Set<InfoItem>) -> [String: String] {
    var info: [String: String] = [:]
    let bundle = Bundle.main
    let infoDictionary = bundle.infoDictionary
    
    if items.contains(.appVersion) {
      if let version = infoDictionary?["CFBundleShortVersionString"] as? String {
        info[InfoItem.appVersion.rawValue] = version
      } else {
        info[InfoItem.appVersion.rawValue] = "N/A"
      }
    }
    
    if items.contains(.appBuild) {
      if let build = infoDictionary?["CFBundleVersion"] as? String {
        info[InfoItem.appBuild.rawValue] = build
      } else {
        info[InfoItem.appBuild.rawValue] = "N/A"
      }
    }
    
    if items.contains(.bundleIdentifier) {
      info[InfoItem.bundleIdentifier.rawValue] = bundle.bundleIdentifier ?? "N/A"
    }
    
    if items.contains(.appName) {
      if let appName = infoDictionary?["CFBundleDisplayName"] as? String {
        info[InfoItem.appName.rawValue] = appName
      } else if let appName = infoDictionary?["CFBundleName"] as? String {
        info[InfoItem.appName.rawValue] = appName
      } else {
        info[InfoItem.appName.rawValue] = "N/A"
      }
    }
    
    return info
  }
}
