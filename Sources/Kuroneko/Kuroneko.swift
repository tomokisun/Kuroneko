import Foundation

@MainActor
public class Kuroneko {
  private var customFields: [CustomField] = []
  private let collector: InfoCollector
  private let formatter: OutputFormatter
  
  public init() {
    self.collector = InfoCollector()
    self.formatter = OutputFormatter()
  }
  
  // 全項目取得
  public func collect() async -> String {
    let info = await collector.collectAll()
    return formatter.format(info: info, customFields: customFields)
  }
  
  // 項目選択取得
  public func collect(items: Set<InfoItem>) async -> String {
    let info = await collector.collect(items: items)
    return formatter.format(info: info, customFields: customFields)
  }
  
  // カテゴリ単位取得
  public func collect(categories: Set<InfoCategory>) async -> String {
    let info = await collector.collectByCategories(categories)
    return formatter.format(info: info, customFields: customFields)
  }
  
  // カスタムフィールド追加（String値）
  public func addCustomField(key: String, value: String) {
    let field = CustomField(key: key, value: .string(value))
    customFields.append(field)
  }
  
  // カスタムフィールド追加（Int値）
  public func addCustomField(key: String, value: Int) {
    let field = CustomField(key: key, value: .int(value))
    customFields.append(field)
  }
  
  // カスタムフィールド追加（CustomFieldValue）
  public func addCustomField(key: String, value: CustomFieldValue) {
    let field = CustomField(key: key, value: value)
    customFields.append(field)
  }
  
  // カスタムフィールドクリア
  public func clearCustomFields() {
    customFields.removeAll()
  }
}
