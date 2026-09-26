# Yoi — Hermes Agent with companion persona
# Blade Runner 2049 aesthetic virtual companion
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU:ru \
    LC_ALL=ru_RU.UTF-8

# System deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates git python3 python3-pip python3-venv \
    locales tmux ffmpeg espeak-ng \
    && locale-gen ru_RU.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Install Hermes
RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

# Install Russian STT (faster-whisper)
RUN /usr/local/lib/hermes-agent/venv/bin/pip install faster-whisper

# Create yoi profile
RUN hermes profile create yoi --clone-from default 2>/dev/null || true

# Copy profile files
COPY profile/SOUL.md /root/.hermes/profiles/yoi/SOUL.md
COPY profile/config.yaml /root/.hermes/profiles/yoi/config.yaml
COPY profile/.env.template /root/.hermes/profiles/yoi/.env.template
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install skills needed by yoi
RUN hermes -p yoi skills install hermes-agent 2>/dev/null || true

WORKDIR /root

ENTRYPOINT ["/entrypoint.sh"]