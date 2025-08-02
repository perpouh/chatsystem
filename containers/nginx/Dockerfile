FROM nginx:1.24-alpine

# 設定テンプレートをコピー
COPY nginx.conf.template /etc/nginx/nginx.conf.template

# 環境変数を設定
ENV APP_HOST=app
ENV APP_PORT=3000

# 設定テンプレートを適用してnginx.confを生成
CMD ["/bin/sh", "-c", "envsubst '$$APP_HOST $$APP_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"] 