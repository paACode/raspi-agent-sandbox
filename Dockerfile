FROM node:20-slim

RUN apt-get update && apt-get install -y \
git curl bash python3 python3-pip \
&& rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai \
    && npm install -g --ignore-scripts @earendil-works/pi-coding-agent


RUN useradd -m -u 1001 coding-agent
USER coding-agent

WORKDIR /home/coding-agent/workspace

CMD ["bash"]
