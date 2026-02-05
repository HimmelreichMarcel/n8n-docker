#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f "docker-compose.yml" ]]; then
  echo "Run this from the repo root (where docker-compose.yml is)." >&2
  exit 1
fi

mkdir -p backups

ts="$(date +%Y-%m-%d_%H-%M-%S)"
file="backups/n8n_backup_${ts}.tgz"

echo "▶ Creating backup: ${file}"
tar -czf "${file}"   ./docker-compose.yml   ./.env   ./data   2>/dev/null || true

echo "✅ Backup created: ${file}"
echo "   Copy this file somewhere safe (your laptop, NAS, etc.)."
