# Kuroneko

iOSデバイスとアプリケーションの情報を収集し、Key-Value形式でテキスト出力するSwiftライブラリです。

## 特徴

- 📱 iOS 17.0以上対応
- 🔍 26の情報項目を取得可能
- 🎯 必要な項目のみを選択して取得
- 📦 カテゴリ単位での取得に対応
- ✨ カスタムフィールドの追加機能
- 📝 整形されたKey-Value形式の出力

## インストール

### Swift Package Manager

```swift
dependencies: [
  .package(url: "https://github.com/tomokisun/Kuroneko.git", from: "1.0.0")
]
```

## 使用方法

### 基本的な使用例

```swift
import Kuroneko

// インスタンスの作成
let kuroneko = Kuroneko()

// すべての情報を取得
let allInfo = kuroneko.collect()
print(allInfo)
```

### 特定の項目のみ取得

```swift
// 特定の項目のみを選択して取得
let selectedInfo = kuroneko.collect(items: [
  .deviceType,
  .appVersion,
  .systemVersion
])
print(selectedInfo)
```

### カテゴリ単位で取得

```swift
// デバイスとアプリケーション情報のみ取得
let categoryInfo = kuroneko.collect(categories: [
  .device,
  .application
])
print(categoryInfo)
```

### カスタムフィールドの追加

```swift
// アプリ固有の情報を追加
kuroneko.addCustomField(key: "user_id", value: "12345")
kuroneko.addCustomField(key: "session_count", value: 42)

let infoWithCustomFields = kuroneko.collect()
print(infoWithCustomFields)
```

## 取得可能な情報

### デバイス情報 (Device)
- `device_model`: デバイスモデル名
- `device_type`: デバイスタイプ（iPhone/iPad）
- `device_name`: デバイス名
- `system_name`: システム名
- `system_version`: iOSバージョン

### アプリケーション情報 (Application)
- `app_version`: アプリバージョン
- `app_build`: ビルド番号
- `bundle_identifier`: バンドルID
- `app_name`: アプリ名

### システムリソース (System Resource)
- `total_memory`: 総メモリ容量（GB）
- `available_memory`: 利用可能メモリ（GB）
- `total_storage`: 総ストレージ容量（GB）
- `available_storage`: 利用可能ストレージ（GB）
- `processor_count`: プロセッサコア数

### ネットワーク情報 (Network)
- `network_type`: ネットワーク種別
- `carrier_name`: キャリア名

### ロケール情報 (Locale)
- `language`: 言語設定
- `region`: 地域設定
- `timezone`: タイムゾーン
- `locale`: ロケール

### 時刻情報 (Time)
- `current_timestamp`: 現在時刻（Unix timestamp）
- `uptime`: システム起動時間

### UI/UX情報 (UI/UX)
- `screen_width`: 画面幅（ポイント）
- `screen_height`: 画面高さ（ポイント）
- `screen_scale`: 画面スケール
- `user_interface_style`: ダーク/ライトモード

## 出力例

```
// Device
device_model: iPhone15,2
device_type: iPhone
device_name: User's iPhone
system_name: iOS
system_version: 18.6.1

// Application
app_version: 1.98.0
app_build: 123
bundle_identifier: com.example.app
app_name: MyApp

// Custom Fields
user_id: 12345
session_count: 42
```

## 要件

- iOS 17.0以上
- Swift 6.1以上
- Xcode 16.0以上

## ライセンス

MIT License
