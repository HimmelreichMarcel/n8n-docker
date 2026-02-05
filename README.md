# n8n on Raspberry Pi (Docker + Tailscale) — friend-friendly repo

This repo is a **simple, copy‑paste guide** to install and run **n8n** on a Raspberry Pi using **Docker Compose**.
It assumes you already have **Tailscale** installed on the Pi and your laptop so you can reach the Pi from anywhere.

## What you’ll get

- ✅ `docker-compose.yml` that runs **n8n + Postgres** (recommended)
- ✅ n8n reachable on your **local network**: `http://<pi-lan-ip>:5678`
- ✅ Also reachable over **Tailscale**: `http://<pi-tailscale-ip>:5678`
- ✅ A tiny “knowledge base” with the *minimum commands* you need

---

## 0) Before you start

You need:

- A Raspberry Pi with Raspberry Pi OS (recommended: 64-bit)
- Internet access
- A user you can SSH in with (usually `pi`)
- Tailscale installed + signed in on:
  - the Raspberry Pi
  - your laptop

---

## 1) How to connect to the Pi (SSH)

### Find the Pi’s IP

**Option A (LAN IP):** on the Pi, run:

```bash
hostname -I
```

**Option B (Tailscale IP):** on the Pi, run:

```bash
tailscale ip -4
```

### SSH in from your laptop

```bash
ssh pi@<PI_IP_ADDRESS>
```

Examples:

```bash
ssh pi@192.168.1.50
ssh pi@100.101.102.103
```

> Tip: If you changed the username, replace `pi` with your username.

---

## 2) Install Docker + Docker Compose

Run this on the Pi (copy/paste):

```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
newgrp docker
```

Install the Docker Compose plugin:

```bash
sudo apt-get update
sudo apt-get install -y docker-compose-plugin
```

Verify:

```bash
docker --version
docker compose version
```

---

## 3) Get this repo onto the Pi

### Option A (recommended): Git clone

```bash
sudo apt-get update
sudo apt-get install -y git
git clone <REPO_URL_HERE>
cd n8n-raspberrypi-tailscale
```

### Option B: Download as ZIP
If you received a zip file, unzip it and `cd` into the folder.

---

## 4) Configure n8n (one-time)

Copy the example env file:

```bash
cp .env.example .env
```

Edit it:

```bash
nano .env
```

Minimum things to change:

- `N8N_ENCRYPTION_KEY` (important)
- `POSTGRES_PASSWORD` (important)

You can generate a good encryption key on the Pi:

```bash
openssl rand -hex 32
```

---

## 5) Start n8n

From the repo folder:

```bash
./bin/n8n up
```

Then open in your browser:

- **LAN:** `http://<pi-lan-ip>:5678`
- **Tailscale:** `http://<pi-tailscale-ip>:5678`

To stop:

```bash
./bin/n8n down
```

---

## 6) Easy day‑to‑day commands

All commands are in `bin/`:

- Start: `./bin/n8n up`
- Stop: `./bin/n8n down`
- Status: `./bin/n8n ps`
- Logs (follow): `./bin/n8n logs`
- Update (pull new images): `./bin/n8n update`
- Restart: `./bin/n8n restart`
- Backup: `./bin/n8n backup`
- Restore: `./bin/n8n restore backups/<file>.tgz`

---

## 7) Where your data lives (important)

This setup uses a folder named `data/`:

- `data/n8n/` — n8n workflows, credentials (encrypted), config
- `data/postgres/` — Postgres database

Backups are stored in `backups/`.

---

## 8) Troubleshooting (fast)

### “Port 5678 already in use”
Something else is using that port. See what:

```bash
sudo lsof -i :5678
```

Then stop the conflicting service or change `N8N_PORT` in `.env`.

### “permission denied” on files
Fix ownership for the repo folder:

```bash
sudo chown -R $USER:$USER .
```

### Check containers are running
```bash
./bin/n8n ps
```

### Inspect logs
```bash
./bin/n8n logs
```

---

## 9) Optional: safer access over the internet

Right now, if someone can reach your Pi IP (LAN or Tailscale), they can reach n8n.

If you want extra safety later:
- Put n8n behind a reverse proxy with HTTPS + auth (Caddy / Nginx)
- Or only access n8n via Tailscale (recommended)

---

## What’s next?

Read the mini docs in:

- `docs/INSTALLATION.md`
- `docs/DOCKER_CHEATSHEET.md`
- `docs/N8N_TUTORIAL.md`
- `docs/TROUBLESHOOTING.md`

Have fun automating 🙂
