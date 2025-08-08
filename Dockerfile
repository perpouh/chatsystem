FROM ruby:3.2-alpine3.18

# 必要なパッケージをインストール
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    tzdata \
    nodejs \
    yarn \
    make \
    git \
    gcc \
    g++ \
    openssl-dev \
    yaml-dev \
    readline-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    postgresql-client \
    libpq-dev \
    musl-dev \
    gcompat

# 作業ディレクトリを設定
WORKDIR /app

RUN gem install rails -v 7.2.2

# GemfileとGemfile.lockをコピー
COPY Gemfile ./

# 依存関係をインストール
# RUN bundle install && \
#     rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#     bundle exec bootsnap precompile --gemfile
# RUN groupadd --system --gid 1000 rails && \
#     useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
#     mkdir -p /app/tmp/sockets && \
#     chown -R rails:rails /app && \
#     chmod -R 777 /app/tmp /app/log

# アプリケーションのソースコードをコピー
COPY . .

# アセットをプリコンパイル
# RUN bundle exec rails assets:precompile

# ポート3000を公開
EXPOSE 3000

# Railsサーバーを起動
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"] 