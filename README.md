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

## Release

This repository uses GitHub Actions for two separate flows:

- `CI`: runs on pushes to `main` and on pull requests, and verifies that the Docker image still builds.
- `Release`: runs when a Git tag matching `v*` is pushed, then validates the build, pushes the image to GHCR, and creates a GitHub Release.

Release with:

```bash
git checkout main
git pull --ff-only
git tag -a v0.1.0 -m "Release v0.1.0"
git push origin main
git push origin v0.1.0
```

Published image tags include:

- `ghcr.io/computbiol/coding-agent-box:v0.1.0`
- `ghcr.io/computbiol/coding-agent-box:0.1.0`
- `ghcr.io/computbiol/coding-agent-box:0.1`
- `ghcr.io/computbiol/coding-agent-box:latest`

## Notes

- GPU support requires the host machine to have NVIDIA Container Toolkit installed.
- The container runs as user `agent` and the user has passwordless sudo access.
- Project files are mounted from `~/coding-agent-box/projects` to `/home/agent/projects`.
- Agent config directories are mounted from `~/coding-agent-box/configs/*` to `/home/agent/.*`.
