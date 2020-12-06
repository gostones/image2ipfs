FROM golang:1.14.4-alpine3.12 as builder
RUN apk add --no-cache bash gcc libc-dev make openssl-dev

WORKDIR /go/src/github.com/jvassev/image2ipfs
COPY . .
ARG GIT_VERSION
RUN make nested-build GIT_VERSION=$GIT_VERSION

# Speed up local builds where vendor is populated
FROM busybox
ENTRYPOINT ["image2ipfs", "server"]
COPY --from=builder /go/bin/image2ipfs /bin
