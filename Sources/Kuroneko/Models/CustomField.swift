import Foundation

public enum CustomFieldValue {
  case string(String)
  case int(Int)
  
  public var stringValue: String {
    switch self {
    case .string(let value):
      return value
    case .int(let value):
      return String(value)
    }
  }
}

public struct CustomField {
  public let key: String
  public let value: CustomFieldValue
  
  public init(key: String, value: CustomFieldValue) {
    self.key = key
    self.value = value
  }
}
