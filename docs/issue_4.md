# Issue #4: DB修正

## 📋 概要

### AsIs（現在の状況）
- ドキュメントとチャットが一対一で紐づいている

### ToBe（目標）
- 製品ProductとチャットChatが一対一で紐づく
- 製品Productは複数のドキュメントDocumentを持つ
- ドキュメントテーブルの内容は今と変わらず、タイトル、URL、摘要とする

## 📝 作業リスト

### 1. **Productモデルの作成**
- [x] `app/models/product.rb` の作成
- [x] Productモデルのバリデーション設定
- [x] Userとの関連付け（`belongs_to :user`）

### 2. **データベースマイグレーション**
- [x] `products`テーブルの作成マイグレーション
  - `user_id` (bigint, not null)
  - `name` (string, not null)
  - `description` (text)
  - `created_at`, `updated_at`
- [x] `documents`テーブルの修正マイグレーション
  - `product_id`カラムの追加（`user_id`から変更）
  - `user_id`カラムの削除
- [x] `chats`テーブルの修正マイグレーション
  - `document_id`カラムを`product_id`に変更

### 3. **モデル関連付けの修正**
- [x] `Document`モデルの修正
  - `belongs_to :user` → `belongs_to :product`
  - `has_one :chat` の削除
- [x] `Chat`モデルの修正
  - `belongs_to :document` → `belongs_to :product`
- [x] `Product`モデルの関連付け
  - `has_many :documents`
  - `has_one :chat`

### 4. **バリデーションの更新**
- [x] `Document`モデルのバリデーション修正
- [x] `Product`モデルのバリデーション追加
- [x] `Chat`モデルのバリデーション確認

### 5. **テストファイルの更新**
- [x] `spec/factories/product.rb` の作成
- [x] `spec/models/product_spec.rb` の作成
- [x] 既存のテストファイルの修正
  - `spec/models/document_spec.rb`
  - `spec/models/chat_spec.rb`

### 6. **データ移行**
- [x] 既存データの移行スクリプト作成
- [x] テストデータの更新

### 7. **インデックスの更新**
- [x] 新しい関連付けに基づくインデックスの追加
- [x] 不要になったインデックスの削除

### 8. **スキーマの確認**
- [x] `db/schema.rb` の更新確認
- [x] 外部キー制約の確認

## ⚠️ 注意事項
- 既存のデータがある場合、データ移行時に注意が必要
- 外部キー制約の順序に注意
- テストの実行で動作確認を必ず行う

## 🔗 関連リンク
- [GitHub Issue #4](https://github.com/perpouh/chatsystem/issues/4)

## 📅 進捗状況
- [x] 作業開始
- [x] 作業完了
- [ ] レビュー完了
- [ ] マージ完了

## ✅ 完了した作業
- Productモデルの作成と設定
- データベースマイグレーションの実行
- モデル関連付けの修正
- バリデーションの更新
- テストファイルの作成と修正
- shoulda-matchersの追加と設定
- 全モデルのテストが成功
