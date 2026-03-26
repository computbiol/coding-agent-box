# Releasing

Create and publish a release from `main` with an annotated `v*` tag.

```bash
git checkout main
git pull --ff-only
git tag -a v0.2.0 -m "Release v0.2.0"
git push origin main
git push origin v0.2.0
```

Pushing a `v*` tag triggers the `Release` workflow, which:

- validates the Docker build
- publishes images to GHCR
- creates a GitHub Release

For `v0.2.0`, the published image tags are:

- `ghcr.io/computbiol/coding-agent-box:v0.2.0`
- `ghcr.io/computbiol/coding-agent-box:0.2.0`
- `ghcr.io/computbiol/coding-agent-box:0.2`
- `ghcr.io/computbiol/coding-agent-box:latest`
