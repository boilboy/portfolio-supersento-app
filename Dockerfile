# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.1
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /app

# 全環境共通のシステムパッケージ
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libpq-dev \
    libvips \
    postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# 開発とビルドに必要な共通パッケージ
FROM base AS dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./

# 開発環境用
FROM dependencies AS development

ENV BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_APP_CONFIG="/usr/local/bundle"

RUN bundle install

COPY bin/docker-entrypoint /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint" ]

EXPOSE 3000
CMD ["./bin/dev"]

# 本番環境用のビルド
FROM dependencies AS build

RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

COPY . .
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# 本番環境用の実行イメージ
FROM base AS production

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

COPY bin/docker-entrypoint /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint" ]

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log tmp
USER rails:rails

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
