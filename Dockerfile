# syntax=docker/dockerfile:1
FROM nikolaik/python-nodejs:python3.11-nodejs20

ENV PYTHONUNBUFFERED=1 \
    HERMES_HOME=/root/.hermes

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl git tmux ca-certificates unzip ffmpeg \
    fonts-liberation fonts-noto-color-emoji fontconfig \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash \
 && /usr/local/lib/hermes-agent/venv/bin/python3 -m pip install --no-cache-dir \
      faster-whisper edge-tts python-telegram-bot

# Yoi profile
COPY profile/config.yaml /root/.hermes/profiles/yoi/config.yaml
COPY profile/SOUL.md /root/.hermes/profiles/yoi/SOUL.md

WORKDIR /root

CMD ["bash", "-lc", "hermes --profile yoi gateway run"]