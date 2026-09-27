FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    HERMES_HOME=/root/.hermes

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl git tmux ca-certificates ffmpeg \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir hermes-agent \
 && pip install --no-cache-dir faster-whisper edge-tts

# Yoi profile
COPY profile/config.yaml /root/.hermes/profiles/yoi/config.yaml
COPY profile/SOUL.md /root/.hermes/profiles/yoi/SOUL.md

WORKDIR /root

CMD ["hermes", "--profile", "yoi", "gateway", "run"]