# ── Йои (Joi) ────────────────────────────────────────────────────────
.PHONY: up down build logs shell restart clean setup

# Настройка перед первым запуском
setup:
	@test -f profile/.env || cp profile/.env.template profile/.env
	@echo "✓ profile/.env создан из шаблона"
	@echo "⚠ Отредактируй profile/.env — TELEGRAM_BOT_TOKEN + ключи API"
	@echo "⚠ Прокси должен быть запущен на хосте (socks5://localhost:10808)"
	@echo "⚠ Затем: make up"

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

# Перезапуск
restart:
	docker compose restart yoi

# Полная очистка
clean:
	docker compose down -v
	@echo "Все данные удалены. .env сохранён."