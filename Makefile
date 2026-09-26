# ── Йои (Joi) ────────────────────────────────────────────────────────
.PHONY: up down build logs shell restart clean

# Запуск
up:
	docker compose up -d
	@echo "💿🌧️ Йои запущена. Проверь: docker compose logs -f yoi"

# Остановка
down:
	docker compose down

# Пересборка
build:
	docker compose build --no-cache

# Логи
logs:
	docker compose logs -f yoi

# Зайти в контейнер
shell:
	docker compose exec yoi bash

# Зайти в tmux-сессию Йои
chat:
	docker compose exec yoi tmux attach -t yoi || docker compose exec yoi hermes -p yoi

# Перезапуск
restart:
	docker compose restart yoi

# Полная очистка (включая volumes!)
clean:
	docker compose down -v
	@echo "Все данные удалены. .env сохранён в profile/"

# Настройка перед первым запуском
setup:
	@test -f profile/.env || cp profile/.env.template profile/.env
	@echo "✓ profile/.env создан из шаблона"
	@echo "⚠ Отредактируй profile/.env — добавь TELEGRAM_BOT_TOKEN и ключи API!"
	@echo "⚠ Затем: make up"