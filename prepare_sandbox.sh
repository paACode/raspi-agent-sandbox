#!/bin/bash

SANDBOX_DIR="$(dirname "$(readlink -f "$0")")"
CURRENT_USER=$(whoami)


echo "=== Configure Docker Group ==="
if groups "$CURRENT_USER" | grep -q '\bdocker\b'; then
    echo "User '$CURRENT_USER' is already in the docker group."
else
    echo "Adding '$CURRENT_USER' to the docker group..."
    sudo usermod -aG docker "$CURRENT_USER"
fi

echo "=== Prepare folders ==="
# sandbox-config: Agent settings (opencode.json)
# mounts to /home/coding-agent/.config"
mkdir -p "$SANDBOX_DIR/sandbox-config"
echo "Added sandbox-config..."

# sandbox-workdir: Shared workdir
# mounts to /home/coding-agent/workdir"
mkdir -p "$SANDBOX_DIR/sandbox-workdir"
echo "Added sandbox-workdir..."
