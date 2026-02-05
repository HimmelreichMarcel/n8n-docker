# Installation guide (Raspberry Pi + Docker + Tailscale)

## Goal

Run n8n on your Raspberry Pi with Docker Compose, then open it from:

- LAN: `http://<pi-lan-ip>:5678`
- Tailscale: `http://<pi-tailscale-ip>:5678`

---

## Step 1 — SSH into the Pi

Find LAN IP:

```bash
hostname -I
```

Find Tailscale IP:

```bash
tailscale ip -4
```

SSH from laptop:

```bash
ssh pi@<PI_IP>
```

---

## Step 2 — Install Docker + Compose

```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
newgrp docker
sudo apt-get update
sudo apt-get install -y docker-compose-plugin
```

Verify:

```bash
docker --version
docker compose version
```

---

## Step 3 — Get the repo

```bash
sudo apt-get install -y git
git clone <REPO_URL_HERE>
cd n8n-raspberrypi-tailscale
```

---

## Step 4 — Configure

```bash
cp .env.example .env
nano .env
```

Generate a secure encryption key:

```bash
openssl rand -hex 32
```

Paste it into `N8N_ENCRYPTION_KEY`.

---

## Step 5 — Start n8n

```bash
./bin/n8n up
```

Open it in a browser:

- `http://<pi-lan-ip>:5678`
- `http://<pi-tailscale-ip>:5678`

Stop:

```bash
./bin/n8n down
```

---

## Step 6 — Autostart on reboot (optional but recommended)

Docker uses `restart: unless-stopped`, so containers should come back after reboot.

Test:

```bash
sudo reboot
```

After reboot, SSH in and run:

```bash
./bin/n8n ps
```

If it’s not running, start it:

```bash
./bin/n8n up
```
