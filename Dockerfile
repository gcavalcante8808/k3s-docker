FROM alpine:3.8 as downloader
ARG K3S_VERSION=v1.18.6+k3s1
RUN apk add --no-cache curl ca-certificates
WORKDIR /usr/src
RUN curl -L --output k3s https://github.com/rancher/k3s/releases/download/${K3S_VERSION}/k3s && \
    chmod +x k3s

FROM debian:10
WORKDIR /usr/local/bin

COPY --from=downloader /usr/src/k3s .
COPY --from=downloader /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 6443
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=2 \
  CMD k3s kubectl version || exit 1

VOLUME /var/lib/rancher /var/lib/kubelet /var/log/containers /var/log/pods
CMD ["./k3s","server"]
