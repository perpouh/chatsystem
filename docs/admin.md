# 管理画面

原則として、ログインユーザーに紐づく情報だけが見えること。他のユーザーの情報にはアクセスできないこと。
ログインしていない場合はログイン画面にリダイレクトすること。

## ルーティング

```
/admin
  /documents index, new, create, edit, update, archive
  /chats index, show, new, create, edit, update, archive
  /chat_sessions index
  /issues index, update, bulk-update
```

## 画面

### ドキュメント(/documents)

ドキュメントの管理を行う。ドキュメントの一覧、新規追加、更新、アーカイブの機能がある
一覧画面にはransackを用いた検索とkaminariを用いたページングが必要

### チャット(/chats)

チャットの管理を行う。チャットは必ずひとつ、参照するドキュメントを持つ。
チャット作成時にAPIキーとシークレットの発行を行う。

## チャットセッション(/chat_sessions)

チャットセッションを表示する。チャットセッションの詳細画面ではセッション内のチャットログ(chat_messages)を閲覧できる。
一覧画面にはransackを用いた検索とkaminariを用いたページングが必要

## イシュー(/issues)

イシューを表示する。イシューの詳細画面では、イシューに紐づくチャットセッションとチャットログ(chat_messages)を閲覧できる。
一覧画面にはransackを用いた検索とkaminariを用いたページングが必要
