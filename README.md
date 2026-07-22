#  RAS |  raspi-agent-sandbox🍓🐋

[![Platform](https://img.shields.io/badge/platform-Raspberry%20Pi%204B-c51a4a?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)
[![Docker](https://img.shields.io/badge/runtime-Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Agent](https://img.shields.io/badge/agent-OpenCode-6366f1)](https://opencode.ai)
[![License: GPL v3](https://img.shields.io/badge/license-GPL%20v3-blue.svg)](LICENSE)


## What is it?

RAS allows you to explore coding agents, without the fear of **rm -rf** your whole computer ([mattshumer](https://x.com/mattshumer_/status/2075657271401390161)) , **API key leaks** or blind installs of shady **malicious packages**. RAS is a docker image and comes pre-installed with [OpenCode](https://opencode.ai), which lets you use powerful hosted models directly without a subscription. I recommend to run RAS on a Raspberry Pi , in my case I use a Raspberry Pi 4B. So even if the Agent finds a way to escalate its privileges out of the docker image , its destruction radius is only limited to the Raspi OS, which can easily be replaced by flashing a new USB Stick. 

<img width="1894" height="1022" alt="image" src="https://github.com/user-attachments/assets/8a6107a6-345c-4fea-91e8-45ac3d1b0f34" />

Screenshot: Example of how I use RAS (tmux to organize my windows [runner, workdir, btop, opencode]

## Why I created this repo?

During my masters in applied information and data science I realized that many students new to programming are blinded by the promise that "coding is largely solved".  They pruchase subscriptions , spend many tokens and allow all priviliges to their coding agents without really understanding what is happening under the hood. I cannot blame them, because student projects besides working can sometimes be a real pain and time consuming. But this comes with the risk of destroying your computer, leaking private information and even getting more dependent on coding agents.  

## RAS Philosophy

- Agents should operate in a sandbox, not your main machine
- Always review agent output before running it (Setup opencode to ask permission before every action)
- Agents should never ever push to a GH-repo (Please just don't)
- Isolation is not paranoia — it is good engineering

Please don't be blinded : You will find videos of senior devs showing you examples how they single-shot a new feature in their code base. This is because they have a solid code base, know exactly what they need and why.
As a junior, you're still building that foundation. Don't play the AI slot machine. Take the scenic route and actually learn from the code.

##  Requirements 

- Raspberry Pi 4B (4GB RAM recommended)
- Raspberry Pi OS Lite 64-bit (recommended) or full OS
- Docker installed

## How to use it?

1. SSH into Raspi from your local Network
2. Clone the project you want to work on into `sandbox-workdir/`
3. Start sandbox 
4. Adjust agent settings in `sandbox-config/` (if you want it less restrictive)
5. Open opencode and have fun
6. Agent can work in `~/workdir` → appears in `sandbox-workdir/` on host
8. You review the code, you test the code, you commit and push the code


##  Setup

**1. Install Docker**

```bash
sudo apt update
sudo apt install docker.io
```

**2. Clone this repo**

```bash
git clone git@github.com:paACode/raspi-agent-sandbox.git
cd raspi-agent-sandbox
```

**3. Prepare Sandbox**
```bash
bash prepare_sandbox.sh
```
**4. Open a new SSH Session**

Note: makes sure USER is loaded within new Docker-Group!
```bash
exit
ssh yourname@192.XXX.X.XXX
```

**5. Build the Sandbox**

```bash
bash build_sandbox.sh
```

**6. Start the sandbox**

```bash
bash run_sandbox.sh
```
Note: You can also open more than one sandbox instance with this command.

**7. Run Opencode**

```bash
opencode
```
