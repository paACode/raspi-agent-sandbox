FROM node:20-slim

RUN apt-get update && apt-get install -y \
    git curl bash python3 python3-pip \
    neovim\
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai 

RUN useradd -m -u 1001 coding-agent
USER coding-agent

WORKDIR /home/coding-agent

CMD ["bash"]
