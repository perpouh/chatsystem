# アーキテクチャ

## 本番環境

 - ECS+ECRでRailsアプリケーションをホスティング
 - RDS(PostgreSQL)を接続してデータを永続化

## ローカル環境

 - プロジェクト直下にdocker-compose.ymlを作成
 - プロジェクト直下にRails用のDockerfileを作成 -> appコンテナ
 - containers/postgresにPostgreSQL用のDockerfileを作成 -> dbコンテナ
 - containers/nginxにNGINX用のDockerfileとnginx.conf.templateを作成 -> nginxコンテナ
 - ホスト端末のブラウザからnginx経由でappコンテナにhttp接続できること
 - appコンテナからdbコンテナに接続できること
