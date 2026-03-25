# coding-agent-box

GPU-enabled Docker environment for coding agents on a fresh Linux machine.

## Included tools

- Node.js
- pixi
- git
- GitHub CLI (`gh`)

## Included coding agents

- OpenCode
- Claude Code
- OpenAI Codex CLI
- PI Coding Agent

## Host directory layout

Create these directories on the host before starting the container:

```bash
mkdir -p ~/coding-agent-box/projects
mkdir -p ~/coding-agent-box/configs/.opencode
mkdir -p ~/coding-agent-box/configs/.claude
mkdir -p ~/coding-agent-box/configs/.codex
mkdir -p ~/coding-agent-box/configs/.pi
```

## Start

Build and launch:

```bash
docker compose build
docker compose up -d
```

Enter the container:

```bash
docker exec -it coding-agent-box bash
```

## Notes

- GPU support requires the host machine to have NVIDIA Container Toolkit installed.
- The container runs as user `agent` and the user has passwordless sudo access.
- Project files are mounted from `~/coding-agent-box/projects` to `/home/agent/projects`.
- Agent config directories are mounted from `~/coding-agent-box/configs/*` to `/home/agent/.*`.
