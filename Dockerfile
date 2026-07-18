FROM node:20-slim

RUN apt-get update && apt-get install -y \
    neovim curl ripgrep fd-find\
    python3-pip uv\
    python3-venv\
    python3-dev\
    build-essential\
    && npm install -g opencode-ai\ 
    && rm -rf /var/lib/apt/lists/*\

ARG UID
ARG GID

RUN if [ -z "$UID" ] || [ -z "$GID" ]; then \
        echo "ERROR: UID and GID build-args are required. Build with --build-arg UID=\$(id -u) --build-arg GID=\$(id -g)" >&2; \
        exit 1; \
    fi && \
    (getent passwd node >/dev/null && userdel -r node || true) && \
    (getent group node >/dev/null && groupdel node || true) && \
    groupadd -g ${GID} coding-agent && \
    useradd -m -u ${UID} -g ${GID} coding-agent

USER coding-agent
WORKDIR /home/coding-agent
CMD ["bash"]
