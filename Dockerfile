FROM golang:1.10.3-alpine AS build

RUN apk add --update \
    git \
  && rm -rf /var/cache/apk/*

RUN go get github.com/kgretzky/evilginx2

FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
    ca-certificates \
    libterm-readline-gnu-perl \
    musl-dev

WORKDIR /app

COPY --from=build /go/bin/evilginx2 /app/evilginx2
COPY --from=build /go/src/github.com/kgretzky/evilginx2/phishlets/*.yaml /app/phishlets/

VOLUME ["/app/phishlets/"]

ENTRYPOINT ["/app/evilginx2"]