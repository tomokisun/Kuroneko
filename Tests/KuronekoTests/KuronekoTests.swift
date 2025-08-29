import Testing
import Foundation
@testable import Kuroneko

@Test func testCollectAll() async throws {
    let kuroneko = Kuroneko()
    let result = kuroneko.collect()
    
    #expect(!result.isEmpty)
    #expect(result.contains("// Device"))
}

@Test func testCollectSpecificItems() async throws {
    let kuroneko = Kuroneko()
    let items: Set<InfoItem> = [.deviceType, .appVersion, .batteryLevel]
    let result = kuroneko.collect(items: items)
    
    #expect(!result.isEmpty)
    #expect(result.contains("device_type:"))
}

@Test func testCollectByCategory() async throws {
    let kuroneko = Kuroneko()
    let categories: Set<InfoCategory> = [.device, .application]
    let result = kuroneko.collect(categories: categories)
    
    #expect(!result.isEmpty)
    #expect(result.contains("// Device"))
    #expect(result.contains("// Application"))
}

@Test func testCustomFields() async throws {
    let kuroneko = Kuroneko()
    
    kuroneko.addCustomField(key: "user_id", value: "12345")
    kuroneko.addCustomField(key: "session_count", value: 42)
    
    let result = kuroneko.collect()
    
    #expect(result.contains("// Custom Fields"))
    #expect(result.contains("user_id: 12345"))
    #expect(result.contains("session_count: 42"))
    
    kuroneko.clearCustomFields()
    let clearedResult = kuroneko.collect()
    #expect(!clearedResult.contains("// Custom Fields"))
}
