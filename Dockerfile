FROM ruby:3.3.10-slim-bookworm AS prepared
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libpq-dev libyaml-dev pkg-config && rm -rf /var/lib/apt/lists/*
RUN ["gem", "install", "bundler", "--version", "2.5.22", "--no-document"]
ENV BUNDLE_FROZEN=true
COPY . .
RUN ["bundle", "install"]
FROM prepared AS test
RUN ["bundle", "exec", "rake", "unit"]
FROM prepared AS runtime
USER 10001:10001
EXPOSE 8401
ENTRYPOINT []
CMD ["sh", "-ec", "timeout 60 bundle exec rails db:migrate; exec bundle exec puma -C config/puma.rb"]
