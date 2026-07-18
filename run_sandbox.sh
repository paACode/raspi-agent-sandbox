#!/bin/bash

SANDBOX_DIR="$(dirname "$(readlink -f "$0")")"
CONTAINER_NAME="agent_sandbox_instance"

if [ "$(docker ps -q -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Container '${CONTAINER_NAME}' is already running. Attaching via bash..."
    docker exec -it "$CONTAINER_NAME" bash
    exit 0
fi

# CPU limit (leaving 1 core for OS)
# Strip all Linux capabilities
# Block privilege escalation
# Internet access, isolated from host network
docker run -it --rm \
--name "$CONTAINER_NAME" \
--cpus="3" \
--cap-drop ALL \
--security-opt no-new-privileges \
--network=bridge \
-v "$SANDBOX_DIR/sandbox-config:/home/coding-agent/.config" \
-v "$SANDBOX_DIR/sandbox-workdir:/home/coding-agent/workdir" \
agent-sandbox
