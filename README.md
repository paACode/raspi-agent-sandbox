# Raspi Agent Sandbox Docker

Isolated Docker environment for running AI coding agents (OpenCode, Pi Coding Agent) on Raspberry Pi.

## What's included

- **OpenCode** (`opencode-ai`) — AI coding agent
- **Pi Coding Agent** (`@earendil-works/pi-coding-agent`) — AI coding agent
- **Python 3** + pip
- **Node.js 20**
- **Git**, curl, bash

## Security

- Non-root user (`coding-agent`)
- All Linux capabilities dropped (`--cap-drop ALL`)
- Privilege escalation blocked
- Isolated bridge network (internet access, no host network)
- Workspace persists on host, rest of container is ephemeral

## Setup

### 1. Install Docker
```bash
curl -fsSL https://get.docker.com | sh

2. Build image

cd agent-docker
sudo docker build -t coding-agent .

3. Run

chmod +x start-agent-sandbox.sh
./start-agent-sandbox.sh

File structure

agent-docker/
├── Dockerfile               # Container definition
├── start-agent-sandbox.sh  # Run script with security flags
└── README.md

/home/paacode/agent-work/    # Persistent workspace (agent output saved here)

Resource limits

┌──────────┬───────────────────────────┐
│ Resource │           Limit           │
├──────────┼───────────────────────────┤
│ RAM      │ 3GB (1GB reserved for OS) │
├──────────┼───────────────────────────┤
│ Swap     │ Disabled                  │
├──────────┼───────────────────────────┤
│ CPUs     │ 3 (1 reserved for OS)     │
└──────────┴───────────────────────────┘

Usage

Inside container:
opencode        # start OpenCode
pi              # start Pi Coding Agent

Agent files persist at /home/paacode/agent-work on host.
