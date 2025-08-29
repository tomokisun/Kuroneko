import Foundation

@MainActor
class InfoCollector {
  private let deviceCollector = DeviceInfoCollector()
  private let appCollector = ApplicationInfoCollector()
  private let systemCollector = SystemResourceCollector()
  private let networkCollector = NetworkInfoCollector()
  private let localeCollector = LocaleInfoCollector()
  private let timeCollector = TimeInfoCollector()
  private let uiCollector = UIInfoCollector()
  
  func collect(items: Set<InfoItem>) async -> [String: String] {
    var allInfo: [String: String] = [:]
    
    // カテゴリごとに必要な項目を分類
    var deviceItems = Set<InfoItem>()
    var appItems = Set<InfoItem>()
    var systemItems = Set<InfoItem>()
    var networkItems = Set<InfoItem>()
    var localeItems = Set<InfoItem>()
    var timeItems = Set<InfoItem>()
    var uiItems = Set<InfoItem>()
    
    for item in items {
      switch item.category {
      case .device:
        deviceItems.insert(item)
      case .application:
        appItems.insert(item)
      case .systemResource:
        systemItems.insert(item)
      case .network:
        networkItems.insert(item)
      case .locale:
        localeItems.insert(item)
      case .time:
        timeItems.insert(item)
      case .ui:
        uiItems.insert(item)
      }
    }
    
    // 各Collectorから情報を収集
    if !deviceItems.isEmpty {
      allInfo.merge(deviceCollector.collect(items: deviceItems)) { _, new in new }
    }
    
    if !appItems.isEmpty {
      allInfo.merge(appCollector.collect(items: appItems)) { _, new in new }
    }
    
    if !systemItems.isEmpty {
      allInfo.merge(systemCollector.collect(items: systemItems)) { _, new in new }
    }
    
    if !networkItems.isEmpty {
      allInfo.merge(networkCollector.collect(items: networkItems)) { _, new in new }
    }
    
    if !localeItems.isEmpty {
      allInfo.merge(localeCollector.collect(items: localeItems)) { _, new in new }
    }
    
    if !timeItems.isEmpty {
      allInfo.merge(timeCollector.collect(items: timeItems)) { _, new in new }
    }
    
    if !uiItems.isEmpty {
      allInfo.merge(uiCollector.collect(items: uiItems)) { _, new in new }
    }
    
    
    return allInfo
  }
  
  func collectAll() async -> [String: String] {
    let allItems = Set(InfoItem.allCases)
    return await collect(items: allItems)
  }
  
  func collectByCategories(_ categories: Set<InfoCategory>) async -> [String: String] {
    var items = Set<InfoItem>()
    
    for category in categories {
      items.formUnion(category.items)
    }
    
    return await collect(items: items)
  }
}
