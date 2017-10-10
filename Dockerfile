FROM drydock/u16golall:v5.8.2 as builder
WORKDIR /hello-world
COPY ./hello-world.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello-world .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /hello-world .
CMD ["./hello-world"]
