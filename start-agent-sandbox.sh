#!/bin/bash

# CPU limit (leaving 1 core for OS)
# Strip all Linux capabilities
# Block privilege escalation
# Internet access, isolated from host network
sudo docker run -it --rm \
--cpus="3" \
--cap-drop ALL \
--security-opt no-new-privileges \
--network=bridge \
-v "$SANDBOX_DIR/sandbox-config:/home/coding-agent/.config" \
-v "$SANDBOX_DIR/sandbox-output:/home/coding-agent/output" \
agent-sandbox
