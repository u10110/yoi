#!/bin/bash
# ── Yoi Entrypoint ────────────────────────────────────────────────────
set -e

PROFILE="${HERMES_PROFILE:-yoi}"
PROFILE_DIR="/root/.hermes/profiles/${PROFILE}"

echo "╭──────────────────────────────────────────╮"
echo "│  💿🌧️  Йои (Joi) — запуск...              │"
echo "╰──────────────────────────────────────────╯"

# Copy .env from template if not exists
if [ ! -f "${PROFILE_DIR}/.env" ] && [ -f "${PROFILE_DIR}/.env.template" ]; then
    echo "⚠ .env не найден. Создаю из шаблона."
    echo "  Отредактируй ${PROFILE_DIR}/.env и перезапусти!"
    cp "${PROFILE_DIR}/.env.template" "${PROFILE_DIR}/.env"
fi

# Wait for sing-box proxy
echo "⏳ Жду прокси (sing-box:10808)..."
for i in $(seq 1 30); do
    if nc -z hermes-sing-box 10808 2>/dev/null; then
        echo "✓ Прокси готов"
        break
    fi
    sleep 1
done

echo "🚀 Запускаю Hermes Gateway с профилем ${PROFILE}..."
exec hermes -p "${PROFILE}" gateway run