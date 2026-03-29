# spacemacs-docker

Build a spacemacs docker image and push to docker hub

## Copilot usage
This repo was generated with github copilot

## Files

- **Dockerfile**: Builds a Docker image with Emacs and Spacemacs pre-installed
- **.github/workflows/docker-build-push.yml**: GitHub Actions workflow to automatically build and push images to Docker Hub

## Setup

### Local Docker Build

Build the image locally:

```bash
docker build -t spacemacs:latest .
```

Run the container:

```bash
docker run -it spacemacs:latest
```

### GitHub Actions Setup

To enable automatic builds and pushes to Docker Hub:

1. **Create Docker Hub Token**:
   - Log in to [Docker Hub](https://hub.docker.com)
   - Go to Account Settings → Security
   - Create a new Personal Access Token

2. **Add GitHub Secrets**:
   - Go to your GitHub repository
   - Settings → Secrets and variables → Actions
   - Add the following secrets:
     - `DOCKER_USERNAME`: Your Docker Hub username
     - `DOCKER_PASSWORD`: Your Docker Hub personal access token

3. **Triggering Builds**:
   - Push to `main` branch: Automatically triggers build and pushes with `latest` and `{branch}` tags
   - Push tags (e.g., `v1.0.0`): Automatically triggers build and pushes with semantic version tags
   - Manual trigger: Go to Actions tab and click "Run workflow"

## Docker Image Usage

Pull the image from Docker Hub:

```bash
docker pull <your-docker-username>/spacemacs:latest
```

Run Emacs with Spacemacs in the container:

```bash
docker run -it <your-docker-username>/spacemacs:latest
```

Run with volume mount to persist your `.emacs.d` configuration:

```bash
docker run -it -v ~/.emacs.d:/root/.emacs.d <your-docker-username>/spacemacs:latest
```
