import Foundation

class OutputFormatter {
  
  func format(
    info: [String: String],
    customFields: [CustomField],
    orderedBy categories: [InfoCategory] = InfoCategory.allCases
  ) -> String {
    var output = ""
    var addedCategories = Set<InfoCategory>()
    
    // カテゴリごとに情報を整形
    for category in categories {
      var categoryItems: [(String, String)] = []
      
      // カテゴリに属する項目を収集
      for item in category.items {
        if let value = info[item.rawValue] {
          categoryItems.append((item.rawValue, value))
        }
      }
      
      // カテゴリに項目があれば出力
      if !categoryItems.isEmpty {
        if !output.isEmpty {
          output += "\n"
        }
        output += "// \(category.rawValue)\n"
        
        for (key, value) in categoryItems {
          output += "\(key): \(value)\n"
        }
        
        addedCategories.insert(category)
      }
    }
    
    // カスタムフィールドを追加
    if !customFields.isEmpty {
      if !output.isEmpty {
        output += "\n"
      }
      output += "// Custom Fields\n"
      
      for field in customFields {
        output += "\(field.key): \(field.value.stringValue)\n"
      }
    }
    
    return output
  }
}
