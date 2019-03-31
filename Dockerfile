FROM alpine:3.8 as downloader
RUN apk add --no-cache curl ca-certificates
WORKDIR /usr/src
RUN curl -L --output k3s https://github.com/rancher/k3s/releases/download/v0.3.0/k3s

FROM debian:9
WORKDIR /usr/local/bin
COPY --from=downloader /usr/src/k3s .
COPY --from=downloader /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
RUN chmod +x k3s
CMD ["./k3s","server"]
