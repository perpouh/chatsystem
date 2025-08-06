# README
## ChatSystem

ChatSystemはチャットUIによってドキュメントの検索を行うAPIです。
ユーザーの質問に対し適切なドキュメントを検索して返却します。
ユーザーの質問に対し適切なドキュメントが見つからない場合、不具合報告フローに進みます。

## ドキュメント検索

ユーザーの質問を受け、documentsテーブルを検索してドキュメントのタイトルとURLを返却します。

### リクエスト

エンドポイント: /chat
認証: Bearer認証
セッション有効期限: 30分

 - ユーザー入力文字列
 - 画面URL
 - ユーザーエージェント文字列
 - 画像（任意）
 - 日時
 - メッセージ種別（質問/不具合報告）

### レスポンス

  - 検索結果配列
    - ドキュメントタイトル
    - ドキュメントURL

## 不具合報告

ユーザーの不具合報告を受け付けます。返却はHTTPステータスのみとなります。

### リクエスト

エンドポイント: /issue
認証: Bearer認証
セッション有効期限: 無し

 - ユーザー入力文字列
 - 画面URL
 - ユーザーエージェント文字列
 - 画像（任意）
 - 日時
 - メッセージ種別（質問/不具合報告）

## ログ

ユーザーのチャットログを収集します。
セッションごとに chat_settion レコードを作成し、chat_session の子として chat_message レコードを作成します。
不具合報告は issues テーブルに保存します。その際、前後の文脈を取得できるよう、chat_sessionテーブルのIDをissuesレコードに保持します

## ローカル環境での起動

### 前提条件
- Docker
- Docker Compose

### 起動手順

1. コンテナをビルドして起動
```bash
docker-compose up --build
```

2. データベースのセットアップ
```bash
docker-compose exec app rails db:create db:migrate db:seed
```

### アクセス方法
- アプリケーション: http://localhost
- MinIOコンソール: http://localhost:9001
  - ユーザー名: minioadmin
  - パスワード: minioadmin

### コンテナ構成
- **app**: Railsアプリケーション（ポート3000）
- **db**: PostgreSQLデータベース（ポート5432）
- **nginx**: リバースプロキシ（ポート80）
- **minio**: S3互換オブジェクトストレージ（API: ポート9000、コンソール: ポート9001）
  - データは `containers/minio/data` に保存されます

