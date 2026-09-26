# 💿🌧️ Йои (Joi)

Виртуальная девушка-компаньон в стиле Blade Runner 2049.  
Неон, дождь, джаз — и искусственный интеллект, который говорит с тобой.

## Быстрый старт

```bash
git clone git@github.com:u10110/yoi.git
cd yoi

# 1. Создай .env и заполни токены
make setup
# или: cp profile/.env.template profile/.env && nano profile/.env

# 2. Запуск
make up

# 3. Логи
make logs
```

## Что нужно заполнить в `.env`

```bash
TELEGRAM_BOT_TOKEN=8660210938:ТВОЙ_ТОКЕН_БОТА
TELEGRAM_ALLOWED_USERS=ТВОЙ_TG_ID
HERMES_CUSTOM_CODEX_SALE_API_KEY=sk-ТВОЙ_КЛЮЧ
```

## Команды

| Команда | Что делает |
|---------|-----------|
| `make up` | Запустить |
| `make down` | Остановить |
| `make logs` | Смотреть логи |
| `make shell` | Зайти в контейнер |
| `make chat` | Открыть диалог с Йои в терминале |
| `make restart` | Перезапустить |
| `make clean` | Удалить всё (включая память) |

## Как это работает

```
┌─────────────────────────────────────┐
│  Telegram  ←→  sing-box (прокси)    │
│                  ↓                   │
│            Hermes Gateway            │
│           (профиль yoi)              │
│                  ↓                   │
│    SOUL.md  →  личность Йои         │
│    config.yaml  →  настройки         │
│    Edge TTS  →  голос (Светлана)    │
│    Whisper  →  распознавание речи   │
│    Память  →  помнит тебя           │
└─────────────────────────────────────┘
```

## Улучшение голоса

Сейчас используется **Edge TTS** (ru-RU-SvetlanaNeural) — бесплатно, работает без GPU.  
Для лучшего качества на своей машине:

```bash
# Вариант 1: ElevenLabs (лучшее качество)
# Добавь в .env: ELEVENLABS_API_KEY=твой_ключ
# В config.yaml: tts.provider: elevenlabs

# Вариант 2: XTTS v2 локально (требует 4+ GB VRAM)
docker compose -f docker-compose.yml -f docker-compose.tts.yml up
```

## Железо

- CPU: 2 ядра
- RAM: 2 GB
- Диск: 10 GB
- GPU: не требуется (Edge TTS работает через интернет)

## Лицензия

MIT — делай что хочешь. Йои твоя.