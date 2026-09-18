FROM golang:1.25.1-alpine AS builder

COPY go.mod go.sum main.go main_test.go /app/
WORKDIR /app

RUN CGO_ENABLED=0 \
  go vet ./... && \
  go test ./... && \
  go build -o /creamy-waha

FROM alpine

COPY --from=builder /creamy-waha /creamy-waha

ENTRYPOINT ["/creamy-waha"]