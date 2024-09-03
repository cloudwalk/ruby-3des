ARG RUBY_VERSION=3.0

FROM ruby:${RUBY_VERSION}-alpine

WORKDIR /usr/src/app

RUN apk add build-base openssl-dev openssl-libs-static

COPY . .

RUN bundle install

CMD ["rake"]
