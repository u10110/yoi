# ── Йои (Joi) ────────────────────────────────────────────────────────
.PHONY: up down build logs shell restart clean setup proxy-config

# Первый запуск (с настройкой)
setup:
	@test -f profile/.env || cp profile/.env.template profile/.env
	@test -f sing-box/config.json || cp sing-box/config.template.json sing-box/config.json
	@echo "✓ profile/.env создан из шаблона"
	@echo "✓ sing-box/config.json создан из шаблона"
	@echo ""
	@echo "⚠ Дальше отредактируй:"
	@echo "  1. profile/.env — TELEGRAM_BOT_TOKEN + ключи API"
	@echo "  2. sing-box/config.json — замени __SERVER__, __UUID__, __SNI__, __PBK__, __SID__"
	@echo "  3. make up"

# Настройка sing-box из VLESS URI
proxy-config:
	@test -n "$(URI)" || (echo "❌ Укажи URI: make proxy-config URI='vless://...'" && exit 1)
	@python3 scripts/vless-to-singbox.py "$(URI)" > sing-box/config.json
	@sing-box check -c sing-box/config.json 2>/dev/null || (echo "⚠ Проверь конфиг вручную: sing-box/config.json" && exit 0)
	@echo "✓ sing-box/config.json готов"

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
	@echo "Все данные удалены. .env и config.json сохранены."