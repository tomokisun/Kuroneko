# CLAUDE.md

このファイルは、このリポジトリで作業する際のClaude Code (claude.ai/code) へのガイダンスを提供します。

## プロジェクト概要

Kuronekoは、デバイスとアプリケーション情報をKey-Value形式で収集するiOS向けSwiftライブラリです。iOS 17.0以上、Swift 6.1以上を対象としています。

## 主要コマンド

### ビルドとテスト
```bash
# パッケージのビルド
swift build

# テストの実行
swift test

# 特定のテストを実行
swift test --filter KuronekoTests.testCollectAll

# 特定プラットフォーム向けビルド
swift build --platform ios
```

### パッケージ管理
```bash
# 依存関係の更新（ある場合）
swift package update

# ビルド成果物のクリーン
swift package clean
```

## アーキテクチャ

### コアコンポーネント

1. **Kuroneko.swift**: 収集とフォーマットを統括するメイン公開APIクラス
   - `collect()`: すべての情報を収集
   - `collect(items:)`: 特定の項目を収集
   - `collect(categories:)`: カテゴリ単位で収集
   - `addCustomField()`: カスタムフィールドを追加

2. **InfoCollector**: 特定のコレクターに委譲する中央コーディネーター
   - すべてのカテゴリ固有コレクターを管理
   - 異なるコレクターからの結果をマージ

3. **OutputFormatter**: 収集データを読みやすいKey-Value形式にフォーマット
   - カテゴリごとに出力をグループ化
   - カスタムフィールドを個別に処理

### コレクターパターン

各情報カテゴリは `Sources/Kuroneko/Collectors/` に独自のコレクタークラスを持ちます：
- DeviceInfoCollector
- ApplicationInfoCollector
- SystemResourceCollector
- BatteryInfoCollector
- NetworkInfoCollector
- LocaleInfoCollector
- TimeInfoCollector
- UIInfoCollector
- SecurityInfoCollector

各コレクター：
- `[String: String]` を返す `collect(items: Set<InfoItem>)` メソッドを持つ
- リクエストされた項目のみを収集
- 生のキー値ペアを返す

### データモデル

- **InfoItem**: 収集可能なすべての項目の列挙型（生の文字列キー付き）
- **InfoCategory**: 関連するInfoItemをグループ化
- **CustomField**: ユーザー定義フィールド（文字列またはint値）

### 新しい情報項目の追加

1. `InfoItem` enumに適切なraw valueを持つ新しいcaseを追加
2. InfoItemの `category` computed propertyを更新
3. InfoCategoryの適切なカテゴリの `items` 配列に項目を追加
4. 関連するCollectorクラスに収集ロジックを実装
5. KuronekoTestsにテストカバレッジを追加

## テスト

テストはSwift Testingフレームワーク（@Test属性）を使用し、#expectアサーションを使います。テストファイルは `Tests/KuronekoTests/KuronekoTests.swift` にあります。

## コード規約

- デバイス情報収集にはUIKitを使用
- 利用不可の情報には "N/A" を返す
- コレクターは単一責任に集中
- 重複を避けるために項目選択にはSet<InfoItem>を使用
- カテゴリヘッダーをコメントとして出力をフォーマット（// Category）