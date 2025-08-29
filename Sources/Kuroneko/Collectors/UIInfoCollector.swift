import UIKit

class UIInfoCollector {
  
  @MainActor
  func collect(items: Set<InfoItem>) -> [String: String] {
    var info: [String: String] = [:]
    
    if let screen = UIScreen.main as UIScreen? {
      if items.contains(.screenWidth) {
        info[InfoItem.screenWidth.rawValue] = String(format: "%.0f", screen.bounds.width)
      }
      
      if items.contains(.screenHeight) {
        info[InfoItem.screenHeight.rawValue] = String(format: "%.0f", screen.bounds.height)
      }
      
      if items.contains(.screenScale) {
        info[InfoItem.screenScale.rawValue] = String(format: "%.0fx", screen.scale)
      }
    }
    
    if items.contains(.userInterfaceStyle) {
      info[InfoItem.userInterfaceStyle.rawValue] = getUserInterfaceStyle()
    }
    
    return info
  }
  
  @MainActor
  private func getUserInterfaceStyle() -> String {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      switch windowScene.traitCollection.userInterfaceStyle {
      case .dark:
        return "Dark"
      case .light:
        return "Light"
      case .unspecified:
        return "Unspecified"
      @unknown default:
        return "Unknown"
      }
    }
    
    return "N/A"
  }
}
