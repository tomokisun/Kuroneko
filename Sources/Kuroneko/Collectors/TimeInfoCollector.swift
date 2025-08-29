import Foundation

class TimeInfoCollector {
  
  func collect(items: Set<InfoItem>) -> [String: String] {
    var info: [String: String] = [:]
    
    if items.contains(.currentTimestamp) {
      let timestamp = Date().timeIntervalSince1970
      info[InfoItem.currentTimestamp.rawValue] = String(format: "%.0f", timestamp)
    }
    
    if items.contains(.uptime) {
      let uptime = ProcessInfo.processInfo.systemUptime
      info[InfoItem.uptime.rawValue] = formatUptime(uptime)
    }
    
    return info
  }
  
  private func formatUptime(_ seconds: TimeInterval) -> String {
    let days = Int(seconds) / 86400
    let hours = (Int(seconds) % 86400) / 3600
    let minutes = (Int(seconds) % 3600) / 60
    let secs = Int(seconds) % 60
    
    if days > 0 {
      return String(format: "%dd %02d:%02d:%02d", days, hours, minutes, secs)
    } else {
      return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
  }
}
