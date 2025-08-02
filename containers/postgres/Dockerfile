FROM postgres:15-alpine

# タイムゾーンを設定
ENV TZ=Asia/Tokyo

# PostgreSQLの設定をコピー（必要に応じて）
# COPY postgresql.conf /etc/postgresql/postgresql.conf

# 初期化スクリプトをコピー（必要に応じて）
# COPY init.sql /docker-entrypoint-initdb.d/

# ポート5432を公開
EXPOSE 5432 