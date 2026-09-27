# ── Sing-box прокси для Telegram (VLESS/Reality) ──────────────────────
FROM alpine:3.20

RUN apk add --no-cache curl && \
    ARCH=$(uname -m) && \
    case "$ARCH" in \
      x86_64)  BIN=x86_64   ;; \
      aarch64) BIN=arm64    ;; \
      *)       BIN=amd64    ;; \
    esac && \
    curl -fsSL "https://github.com/SagerNet/sing-box/releases/download/v1.10.5/sing-box-1.10.5-linux-${BIN}.tar.gz" \
      -o /tmp/sb.tar.gz && \
    tar -xzf /tmp/sb.tar.gz -C /tmp && \
    cp /tmp/sing-box-*/sing-box /usr/local/bin/sing-box && \
    chmod +x /usr/local/bin/sing-box && \
    rm -rf /tmp/sb.tar.gz /tmp/sing-box-*

COPY sing-box-config.json /etc/sing-box/config.json

ENTRYPOINT ["sing-box", "run", "-c", "/etc/sing-box/config.json"]