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

echo "🚀 Запускаю Hermes Gateway с профилем ${PROFILE}..."
exec hermes -p "${PROFILE}" gateway run