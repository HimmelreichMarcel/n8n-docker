# Docker mini cheat sheet (only what you need)

## Where you run commands

Run everything from the repo folder:

```bash
cd n8n-raspberrypi-tailscale
```

## Compose commands

Status:

```bash
docker compose ps
```

Start:

```bash
docker compose up -d
```

Stop:

```bash
docker compose down
```

Logs:

```bash
docker compose logs -f --tail=200
```

Update images:

```bash
docker compose pull
docker compose up -d
```

## Basic Docker commands

List all containers:

```bash
docker ps -a
```

See disk usage:

```bash
docker system df
```

Clean unused stuff (safe-ish, but don’t do it daily):

```bash
docker system prune
```

## Common “what’s my IP?” commands

LAN IP:

```bash
hostname -I
```

Tailscale IP:

```bash
tailscale ip -4
```
