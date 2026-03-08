FROM golang:1.24-alpine AS builder

WORKDIR /app
ENV GOPROXY=https://goproxy.cn,direct

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /ds2api ./cmd/ds2api

FROM alpine:3.19

WORKDIR /app

RUN apk --no-cache add ca-certificates

COPY --from=builder /ds2api /usr/local/bin/ds2api
COPY --from=builder /app/sha3_wasm_bg.7b9ca65ddd.wasm /app/sha3_wasm_bg.7b9ca65ddd.wasm
COPY --from=builder /app/config.example.json /app/config.example.json

EXPOSE 10000

ENV PORT=10000

CMD ["/usr/local/bin/ds2api"]
