#!/usr/bin/env bash
set -euo pipefail

backup="${1:-}"

if [[ "${backup}" == "" ]]; then
  echo "Usage: ./bin/restore.sh backups/<file>.tgz" >&2
  exit 1
fi

if [[ ! -f "${backup}" ]]; then
  echo "Backup file not found: ${backup}" >&2
  exit 1
fi

echo "⚠ This will STOP n8n and overwrite ./data and ./.env from the backup."
echo "   If you are not sure, press Ctrl+C now."
sleep 3

echo "⏹ Stopping containers..."
docker compose down || true

echo "🧹 Removing current data folder..."
rm -rf ./data

echo "▶ Restoring from backup..."
tar -xzf "${backup}" -C .

echo "▶ Starting containers..."
docker compose up -d

echo "✅ Restore complete."
