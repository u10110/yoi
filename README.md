# 💿🌧️ Йои (Joi)

Виртуальная девушка-компаньон в стиле Blade Runner 2049.  
Неон, дождь, джаз — и искусственный интеллект, который говорит с тобой.

## Быстрый старт

```bash
git clone git@github.com:u10110/yoi.git
cd yoi

# 1. Создай .env
make setup

# 2. Отредактируй profile/.env — TELEGRAM_BOT_TOKEN + ключи API

# 3. Прокси должен быть запущен локально (socks5://localhost:10808)

# 4. Запуск
make up
make logs
```

## Структура

```
yoi/
├── docker-compose.yml       # только агент (без прокси)
├── Dockerfile               # сборка Hermes + профиль yoi
├── Makefile                 # make up/down/logs
├── profile/
│   ├── SOUL.md             # личность Йои (Blade Runner 2049)
│   ├── config.yaml         # модель Codex.sale, TTS Edge, STT Whisper
│   └── .env.template       # шаблон для токенов
└── scripts/
    └── entrypoint.sh
```

## Что нужно

| Компонент | Где взять |
|-----------|----------|
| Telegram Bot | @BotFather → `TELEGRAM_BOT_TOKEN` |
| TG ID | @userinfobot → `TELEGRAM_ALLOWED_USERS` |
| Codex.sale ключ | codex.sale → `HERMES_CUSTOM_CODEX_SALE_API_KEY` |
| VLESS прокси | уже запущен локально, порт 10808 |

## Команды

| Команда | Что делает |
|---------|-----------|
| `make up` | Запустить |
| `make down` | Остановить |
| `make logs` | Логи |
| `make shell` | Зайти в контейнер |
| `make build` | Пересобрать |
| `make clean` | Удалить всё |

## Как работает

```
Telegram ← VLESS-прокси (хост:10808) → Hermes Gateway (yoi)
                                            ↓
                              SOUL.md → личность Йои
                              Edge TTS → голос (Светлана)
                              Whisper → распознавание речи
                              Память → помнит тебя
```

## Голос

Сейчас **Edge TTS** (ru-RU-SvetlanaNeural) — бесплатно, без GPU.  
Для XTTS v2 локально (4+ GB VRAM) — добавить отдельный сервис.

## Железо

CPU 2 ядра, RAM 2 GB, диск 10 GB. GPU не требуется.

## Лицензия

MIT