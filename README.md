# 💿🌧️ Йои (Joi)

Виртуальная девушка-компаньон в стиле Blade Runner 2049.  
Неон, дождь, джаз — и искусственный интеллект, который говорит с тобой.

## Быстрый старт

```bash
git clone git@github.com:u10110/yoi.git
cd yoi

# 1. Создай .env и конфиг прокси
make setup

# 2. Отредактируй:
#    profile/.env — TELEGRAM_BOT_TOKEN + ключи API
#    sing-box/config.json — данные VLESS-прокси

# 3. Запуск
make up
make logs
```

## Структура

```
yoi/
├── docker-compose.yml       # yoi + sing-box прокси
├── Dockerfile                # Сборка Hermes с профилем yoi
├── Makefile                  # make up/down/logs/shell
├── profile/
│   ├── SOUL.md              # Личность Йои
│   ├── config.yaml          # Настройки агента
│   └── .env.template        # Шаблон для токенов
├── sing-box/
│   ├── Dockerfile           # Сборка sing-box из бинарника
│   ├── config.template.json # Шаблон VLESS-конфига
│   └── config.json          # Твой конфиг (не коммитить!)
└── scripts/
    └── entrypoint.sh        # Автозапуск гейтвея
```

## Что нужно заполнить

### `profile/.env`

```bash
TELEGRAM_BOT_TOKEN=8660210938:ТВОЙ_ТОКЕН_БОТА
TELEGRAM_ALLOWED_USERS=ТВОЙ_TG_ID
HERMES_CUSTOM_CODEX_SALE_API_KEY=sk-ТВОЙ_КЛЮЧ
```

### `sing-box/config.json`

Замени `__SERVER__`, `__UUID__`, `__SNI__`, `__PBK__`, `__SID__` на значения из твоего VLESS URI.

Или автоматически:
```bash
make proxy-config URI='vless://uuid@host:443?...'
```

## Команды

| Команда | Что делает |
|---------|-----------|
| `make setup` | Создать .env и config.json из шаблонов |
| `make up` | Запустить |
| `make down` | Остановить |
| `make logs` | Логи |
| `make shell` | Зайти в контейнер |
| `make build` | Пересобрать образы |
| `make restart` | Перезапустить |
| `make clean` | Удалить всё (включая память) |

## Как это работает

```
┌─────────────────────────────────────┐
│  Telegram  ←→  sing-box (VLESS)     │
│                  ↓                   │
│            Hermes Gateway            │
│           (профиль yoi)              │
│                  ↓                   │
│    SOUL.md  →  личность Йои         │
│    Edge TTS  →  голос               │
│    Whisper   →  распознавание речи  │
│    Память    →  помнит тебя         │
└─────────────────────────────────────┘
```

## Железо

- CPU: 2 ядра
- RAM: 2 GB
- Диск: 10 GB
- GPU: не требуется

## Улучшение голоса

Сейчас используется **Edge TTS** (ru-RU-SvetlanaNeural) — бесплатно, без GPU.  
Для XTTS v2 на своей машине (4+ GB VRAM) добавь отдельный сервис в docker-compose.

## Лицензия

MIT