#!/bin/bash

AGENT_UID=1001  
# sandbox-config: Agent settings (opencode.json, pi-agent config etc.)
#                 Mounts to ~/.config inside container.
#                 Writable folder shared with host. Modify settings here.
mkdir -p "$HOME/coding-agent/sandbox-config"
sudo chown "$AGENT_UID:$AGENT_UID" "$HOME/coding-agent/sandbox-config"

# sandbox-input: Files you want agent to work with (code, docs, data)
#                Mounts to ~/input inside container. Read-only.
mkdir -p "$HOME/coding-agent/sandbox-input"

# sandbox-output: Agent writes results here (generated code, outputs)
#                 Mounts to ~/output inside container.
#                 Writable folder shared with host. Pick up results here.
mkdir -p "$HOME/coding-agent/sandbox-output"
sudo chown "$AGENT_UID:$AGENT_UID" "$HOME/coding-agent/sandbox-output"

# CPU limit (leaving 1 core for OS)
# Strip all Linux capabilities
# Block privilege escalation
# Internet access, isolated from host network
sudo docker run -it --rm \
--cpus="3" \
--cap-drop ALL \
--security-opt no-new-privileges \
--network=bridge \
-v "$HOME/coding-agent/sandbox-config:/home/coding-agent/.config" \
-v "$HOME/coding-agent/sandbox-input:/home/coding-agent/input:ro" \
-v "$HOME/coding-agent/sandbox-output:/home/coding-agent/output" \
agent-sandbox
