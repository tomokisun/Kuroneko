import Foundation

class SystemResourceCollector {
  
  func collect(items: Set<InfoItem>) -> [String: String] {
    var info: [String: String] = [:]
    
    if items.contains(.totalMemory) {
      info[InfoItem.totalMemory.rawValue] = formatMemory(ProcessInfo.processInfo.physicalMemory)
    }
    
    if items.contains(.availableMemory) {
      info[InfoItem.availableMemory.rawValue] = getAvailableMemory()
    }
    
    if items.contains(.totalStorage) {
      info[InfoItem.totalStorage.rawValue] = getTotalStorage()
    }
    
    if items.contains(.availableStorage) {
      info[InfoItem.availableStorage.rawValue] = getAvailableStorage()
    }
    
    if items.contains(.processorCount) {
      info[InfoItem.processorCount.rawValue] = String(ProcessInfo.processInfo.processorCount)
    }
    
    return info
  }
  
  private func formatMemory(_ bytes: UInt64) -> String {
    let gb = Double(bytes) / 1073741824.0 // 1024 * 1024 * 1024
    return String(format: "%.2f GB", gb)
  }
  
  private func getAvailableMemory() -> String {
    var info = mach_task_basic_info()
    var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
    
    let result = withUnsafeMutablePointer(to: &info) {
      $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
        task_info(mach_task_self_,
                  task_flavor_t(MACH_TASK_BASIC_INFO),
                  $0,
                  &count)
      }
    }
    
    if result == KERN_SUCCESS {
      let usedMemory = info.resident_size
      let totalMemory = ProcessInfo.processInfo.physicalMemory
      let availableMemory = totalMemory - usedMemory
      return formatMemory(availableMemory)
    }
    
    return "N/A"
  }
  
  private func getTotalStorage() -> String {
    do {
      let systemAttributes = try FileManager.default.attributesOfFileSystem(
        forPath: NSHomeDirectory() as String
      )
      
      if let space = systemAttributes[.systemSize] as? NSNumber {
        let bytes = space.uint64Value
        return formatMemory(bytes)
      }
    } catch {
      // エラー処理
    }
    
    return "N/A"
  }
  
  private func getAvailableStorage() -> String {
    do {
      let systemAttributes = try FileManager.default.attributesOfFileSystem(
        forPath: NSHomeDirectory() as String
      )
      
      if let space = systemAttributes[.systemFreeSize] as? NSNumber {
        let bytes = space.uint64Value
        return formatMemory(bytes)
      }
    } catch {
      // エラー処理
    }
    
    return "N/A"
  }
}
