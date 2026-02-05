# n8n quick tutorial (first 20 minutes)

## 1) Open n8n

Open in your browser:

- `http://<pi-lan-ip>:5678` or
- `http://<pi-tailscale-ip>:5678`

Follow the on-screen setup.

---

## 2) Create your first workflow (Hello World)

1. Click **New Workflow**
2. Add a node: **Manual Trigger**
3. Add a node: **Set**
   - Add a field called `message`
   - Set it to: `hello from my raspberry pi`
4. Add a node: **Respond to Webhook** (skip for now) OR **NoOp**
5. Click **Execute workflow**

You should see the data move from node to node.

---

## 3) Create a webhook you can call from anywhere

1. Add node: **Webhook**
2. Set method to `GET`
3. Copy the **Test URL**
4. Click **Execute workflow** (it starts listening)
5. On your laptop, call:

```bash
curl "<PASTE_TEST_URL_HERE>"
```

Now you triggered the workflow remotely.

> If you want webhooks to work reliably from outside, set `WEBHOOK_URL` in `.env`
> to your Tailscale URL, e.g. `http://<pi-tailscale-ip>:5678/`

---

## 4) The most useful habit

When something “doesn’t work”:

1. Check if containers are running:
   ```bash
   ./bin/n8n ps
   ```
2. Read logs:
   ```bash
   ./bin/n8n logs
   ```
3. Restart:
   ```bash
   ./bin/n8n restart
   ```
