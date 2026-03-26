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

Pull and launch the published image:

```bash
docker compose pull
docker compose up -d
```

To pin a specific published version:

```bash
CODING_AGENT_BOX_IMAGE=ghcr.io/computbiol/coding-agent-box:v0.1.0 docker compose up -d
```

Enter the container:

```bash
docker exec -it coding-agent-box bash
```

## Local build

To build the image locally instead of pulling from GHCR:

```bash
docker compose -f docker-compose.yml -f docker-compose.build.yml up -d --build
```

## Maintenance

- Release instructions for maintainers are in `docs/releasing.md`.

## Notes

- GPU support requires the host machine to have NVIDIA Container Toolkit installed.
- The container runs as user `agent` and the user has passwordless sudo access.
- Project files are mounted from `~/coding-agent-box/projects` to `/home/agent/projects`.
- Agent config directories are mounted from `~/coding-agent-box/configs/*` to `/home/agent/.*`.
