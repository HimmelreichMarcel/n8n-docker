# Troubleshooting

## n8n doesn’t load in the browser

1) Check containers:

```bash
./bin/n8n ps
```

2) View logs:

```bash
./bin/n8n logs
```

3) Ensure you’re using the correct IP:

- LAN IP: `hostname -I`
- Tailscale IP: `tailscale ip -4`

Try:

- `http://<ip>:5678`

---

## “ARM / image not supported” errors

Make sure you are on **64‑bit Raspberry Pi OS** (arm64). n8n’s official Docker image supports ARM64.
If you’re on 32-bit (armv7), upgrade to 64-bit OS.

---

## n8n starts but workflows fail / DB connection errors

- Postgres might still be starting.
- Wait 20–30 seconds, then:

```bash
./bin/n8n logs
```

If it keeps failing, reset *only if you don’t need the data*:

```bash
./bin/n8n down
sudo rm -rf data/postgres
./bin/n8n up
```

---

## Backups

Create a backup:

```bash
./bin/n8n backup
```

Restore:

```bash
./bin/n8n restore backups/<file>.tgz
```
