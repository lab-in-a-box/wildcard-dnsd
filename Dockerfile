FROM ruby:alpine AS build
RUN apk add --no-cache alpine-sdk ruby-dev
WORKDIR /usr/src/app
COPY . .
ENV GEM_HOME=/usr/local
RUN gem build wildcard-dnsd.gemspec
RUN gem install ./wildcard-dnsd-*.gem


FROM ruby:alpine
RUN apk add --no-cache ruby ruby-io-console ruby-json
COPY --from=build /usr/local/ /usr/local/
ENV GEM_HOME=/usr/local

EXPOSE 53/udp
CMD ["wildcard-dnsd"]
