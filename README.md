#  raspi-agent-sandbox🍓

[![Platform](https://img.shields.io/badge/platform-Raspberry%20Pi%204B-c51a4a?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)
[![Docker](https://img.shields.io/badge/runtime-Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Agent](https://img.shields.io/badge/agent-OpenCode-6366f1)](https://opencode.ai)
[![License: GPL v3](https://img.shields.io/badge/license-GPL%20v3-blue.svg)](LICENSE)

> *With great power comes great responsibility ⚖️!*

API keys leak in public repos every day. Dependencies get compromised. Malicious packages slip into ecosystems. One wrong `npm install` and something is reading your files, exfiltrating your keys, or worse.

AI coding agents make this worse. Experienced developers know to isolate their tools. People new to coding often don't — and that is where things go wrong. When you run an agent locally without isolation, it can read all your files, write anywhere, install packages, and make unrestricted network requests. Most tutorials don't mention this.

This project demonstrates how to run an AI agent responsibly — isolated in a Docker sandbox on a Raspberry Pi 4B. We use [OpenCode](https://opencode.ai), which lets you use powerful hosted models directly without a subscription.

> [!IMPORTANT]
> **Every permission is a liability. Agents will use the access you grant them. Responsibility remains yours; do not trust blindly, and make sure you understand what is happening under the hood.**

---

## 🧠 Philosophy

- Agents should operate in a box, not your machine
- Always review agent output before using it
- Always review every command an agent executes
- Always know what files an agent can read
- Isolation is not paranoia — it is good engineering

---

## 👁️ OpenCode Permission Model

OpenCode is configured to ask for permission before every action — including reading files. This is intentional. It forces you to stay aware of what the agent is doing at every step.

When OpenCode asks *"can I read this file?"* — that is the point. You should know the answer. You should decide consciously, not just let an agent roam freely through your codebase.

---

## 🏗️ Isolation Architecture

Two layers of isolation: physical (a dedicated Raspberry Pi) and logical (Docker). Even if something goes wrong, the blast radius is limited to the Pi. Recovery is as simple as flashing a new OS to a USB stick.

```
┌─────────────────────────────────────────────────────────────┐
│  Your Network                                               │
│                                                             │
│   Laptop / Phone                                            │
│   └── SSH                                                   │
│              │                                              │
│              ▼                                              │
│   ┌──────────────────────────────────────────────────────┐  │
│   │  Raspberry Pi 4B (OS Lite)                           │  │
│   │                                                      │  │
│   │  ~/raspi-agent-sandbox/                              │  │
│   │  ├── sandbox-config/                                 │  │
│   │  ├── sandbox-input/                                  │  │
│   │  └── sandbox-output/                                 │  │
│   │              │                                       │  │
│   │              ▼                                       │  │
│   │  ┌────────────────────────────────────────────────┐  │  │
│   │  │  Docker Container (agent-sandbox)              │  │  │
│   │  │                                                │  │  │
│   │  │  User: coding-agent (non-root, UID 1001)       │  │  │
│   │  │  Capabilities: none                            │  │  │
│   │  │  Privilege escalation: blocked                 │  │  │
│   │  │                                                │  │  │
│   │  │  ~/.config  ◄── sandbox-config (read/write)    │  │  │
│   │  │  ~/input    ◄── sandbox-input  (read-only)     │  │  │
│   │  │  ~/output   ──► sandbox-output (read/write)    │  │  │
│   │  │                                                │  │  │
│   │  │  [opencode]                                    │  │  │
│   │  │       │                                        │  │  │
│   │  │       └── internet (API calls only)            │  │  │
│   │  └────────────────────────────────────────────────┘  │  │
│   └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## ⚙️ How It Works

1. SSH into Raspi from anywhere
2. Drop files into `sandbox-input/` — agent can read but not modify them
4. Start sandbox — OpenCode runs isolated inside Docker
5. Adjust agent settings in `sandbox-config/` (if you want it less restrictive)
6. Agent writes results to `~/output` → appears in `sandbox-output/` on host
7. Review output on host before copying into your real project

---

## 📦 Installed Agent

- [OpenCode](https://opencode.ai) — AI coding agent (`opencode`) — no sign-up required

---

## 📋 Requirements

- Raspberry Pi 4B (4GB RAM recommended)
- Raspberry Pi OS Lite 64-bit (recommended) or full OS
- Docker

---

## 🚀 Setup

### 1. Install Docker

```bash
curl -fsSL https://get.docker.com | sh
```

### 2. Clone this repo

```bash
git clone git@github.com:paACode/raspi-agent-sandbox.git
cd raspi-agent-sandbox
```

### 3. Build the image

```bash
sudo docker build -t agent-sandbox .
```

### 4. Start the sandbox

```bash
bash start-agent-sandbox.sh
```

---

## 🛠️ Usage

### Drop files for the agent

```bash
cp myproject.py ~/raspi-agent-sandbox/sandbox-input/
```

Agent sees it at `~/input/myproject.py` inside container. Read-only — agent cannot modify your original.

### Configure OpenCode

`sandbox-config/` is bidirectional — OpenCode writes its config there, you can edit from host.
No container restart needed — kill OpenCode, edit config on host, relaunch inside container.

```bash
# Edit config from host
nvim ~/raspi-agent-sandbox/sandbox-config/opencode/opencode.json
```

### Run OpenCode inside container and have fun 😎

```bash
opencode
```

### Review output

```bash
ls ~/raspi-agent-sandbox/sandbox-output/
```

Only copy files you have reviewed into your real project.

---

## 🔒 Security Model

| Protection | How |
|---|---|
| 🖥️ Physical isolation | Runs on separate Raspberry Pi, not your main machine |
| 👤 Non-root user | Agent runs as `coding-agent` (UID 1001) |
| 🚫 No capabilities | `--cap-drop ALL` strips all Linux privileges |
| ⛔ No privilege escalation | `--security-opt no-new-privileges` |
| 🌐 Isolated network | Bridge network — internet yes, host network no |
| 📁 Read-only input | Agent cannot modify your source files |
| 🗑️ Ephemeral container | `--rm` — container deleted on exit, clean slate |
| ⚡ CPU limit | `--cpus="3"` — leaves 1 core for OS |
| 👁️ Permission prompts | OpenCode asks before every action, including file reads |

---

## ⚠️ Important Reminder

> [!WARNING]
> Always review every file and every command your agent executed.
> Agents can make mistakes, introduce vulnerabilities, or do unexpected things.
> The sandbox limits the blast radius — your review is the last line of defense.

---

## 📁 File Structure

```
raspi-agent-sandbox/
├── Dockerfile                  # Container definition
├── start-agent-sandbox.sh      # Launch script with security flags
└── README.md
```
