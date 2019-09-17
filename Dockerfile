FROM golang:1.10.3-alpine AS build

RUN apk add --update \
    git \
  && rm -rf /var/cache/apk/*

RUN wget -O /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.5.4/dep-linux-amd64 && chmod +x /usr/local/bin/dep

RUN go get github.com/kgretzky/evilginx2

FROM alpine:3.8

RUN apk add --update \
    ca-certificates \
  && rm -rf /var/cache/apk/*

WORKDIR /app

COPY --from=build /go/bin/evilginx2 /app/evilginx2
COPY ./phishlets/*.yaml /app/phishlets/

VOLUME ["/app/phishlets/"]

EXPOSE 443 80 53/udp

ENTRYPOINT ["/app/evilginx2"]