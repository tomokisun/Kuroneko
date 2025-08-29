import Foundation

class LocaleInfoCollector {
  
  func collect(items: Set<InfoItem>) -> [String: String] {
    var info: [String: String] = [:]
    let locale = Locale.current
    
    if items.contains(.language) {
      if let languageCode = locale.language.languageCode?.identifier {
        info[InfoItem.language.rawValue] = languageCode
      } else {
        info[InfoItem.language.rawValue] = "N/A"
      }
    }
    
    if items.contains(.region) {
      if let regionCode = locale.region?.identifier {
        info[InfoItem.region.rawValue] = regionCode
      } else {
        info[InfoItem.region.rawValue] = "N/A"
      }
    }
    
    if items.contains(.timezone) {
      info[InfoItem.timezone.rawValue] = TimeZone.current.identifier
    }
    
    if items.contains(.locale) {
      info[InfoItem.locale.rawValue] = locale.identifier
    }
    
    return info
  }
}
