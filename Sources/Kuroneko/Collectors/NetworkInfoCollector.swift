import Foundation
import Network
import CoreTelephony

final class NetworkInfoCollector: @unchecked Sendable {
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue(label: "NetworkMonitor")
  private var currentPath: NWPath?
  
  init() {
    monitor.pathUpdateHandler = { [weak self] path in
      self?.currentPath = path
    }
    monitor.start(queue: queue)
  }
  
  func collect(items: Set<InfoItem>) -> [String: String] {
    var info: [String: String] = [:]
    
    if items.contains(.networkType) {
      info[InfoItem.networkType.rawValue] = getNetworkType()
    }
    
    if items.contains(.carrierName) {
      info[InfoItem.carrierName.rawValue] = getCarrierName()
    }
    
    return info
  }
  
  private func getNetworkType() -> String {
    guard let path = currentPath else {
      return "Unknown"
    }
    
    if path.status != .satisfied {
      return "None"
    }
    
    if path.usesInterfaceType(.wifi) {
      return "WiFi"
    } else if path.usesInterfaceType(.cellular) {
      return "Cellular"
    } else if path.usesInterfaceType(.wiredEthernet) {
      return "Ethernet"
    } else {
      return "Other"
    }
  }
  
  private func getCarrierName() -> String {
    let networkInfo = CTTelephonyNetworkInfo()
    
    if let carriers = networkInfo.serviceSubscriberCellularProviders {
      let carrierNames = carriers.compactMap { (key, carrier) in
        carrier.carrierName
      }
      
      if !carrierNames.isEmpty {
        return carrierNames.joined(separator: ", ")
      }
    }
    
    return "N/A"
  }
  
  deinit {
    monitor.cancel()
  }
}
