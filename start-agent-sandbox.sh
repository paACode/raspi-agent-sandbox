  #!/bin/bash

  # Create persistent workspace on host if not exists
  mkdir -p /home/paacode/agent-work

  # RAM limit (leaving 1GB for OS)
  # Disable swap (same as memory = no swap)
  # CPU limit (leaving 1 core for OS)
  # Strip all Linux capabilities
  # Block privilege escalation
  # Internet access, isolated from host network
  # Persist workspace
  sudo docker run -it --rm \
    --memory="3g" \
    --memory-swap="3g" \
    --cpus="3" \
    --cap-drop ALL \
    --security-opt no-new-privileges \
    --network=bridge \
    -v /home/paacode/agent-work:/home/coding-agent/workspace \
    coding-agent
