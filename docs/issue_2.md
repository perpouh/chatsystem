# Issue #2: チャットメッセージモデルを作成する

## 概要
チャットメッセージモデルの実装とバリデーション、テストの作成

## 現在の状況
- ✅ マイグレーションファイル作成済み (`db/migrate/20250806065507_create_chat_messages.rb`)
- ❌ モデルファイルのバリデーション未実装
- ❌ アソシエーション未定義
- ❌ テスト未実装

## タスクリスト

### 1. モデルファイルの実装
- [x] `app/models/chat_message.rb`にアソシエーションを追加
  - `belongs_to :chat_session`の定義
- [x] バリデーションを追加
  - チャットセッションの存在確認
  - メッセージの必須チェック
  - メッセージの文字数制限（1000文字以下）
  - スクリーンショットURLのURL形式バリデーション（オプション）

### 2. テストファイルの実装
- [x] `spec/models/chat_message_spec.rb`の作成・実装
  - チャットセッションが存在しない場合の保存失敗テスト
  - メッセージが空の場合の保存失敗テスト
  - メッセージが1000文字を超えた場合のエラーテスト
  - スクリーンショットURLが空でも保存できるテスト
  - スクリーンショットURLが不正なURL形式の場合のエラーテスト

### 3. ファクトリーの実装
- [x] `spec/factories/chat_messages.rb`の作成・実装
  - 基本的なチャットメッセージファクトリー
  - スクリーンショットURL付きのファクトリー
  - 長いメッセージのファクトリー（テスト用）

### 4. マイグレーションファイルの確認
- [x] 現在のマイグレーションが要件を満たしているか確認
  - `chat_session`の外部キー制約
  - `message`カラムの型（string）
  - `screen_shot_url`カラムの型（text）

### 5. データベーススキーマの確認
- [x] `db/schema.rb`の更新確認
- [x] マイグレーション実行後のテーブル構造確認

## 実装詳細

### モデル要件
```ruby
class ChatMessage < ApplicationRecord
  belongs_to :chat_session
  
  validates :chat_session, presence: true
  validates :message, presence: true, length: { maximum: 1000 }
  validates :screen_shot_url, url: true, allow_blank: true
end
```

### テスト要件
- バリデーションテスト
- アソシエーションテスト
- エッジケースのテスト

## 完了条件
- [x] すべてのバリデーションが正常に動作する
- [x] すべてのテストが通る
- [x] ファクトリーが正常に動作する
- [x] マイグレーションが正常に実行できる

## 参考リンク
- [GitHub Issue #2](https://github.com/perpouh/chatsystem/issues/2)
