**Ubuntu** image from https://hub.docker.com/_/ubuntu

Hosted on [GitHub Container Registry](https://github.com/orgs/MaastrichtU-IDS/packages/container/package/ubuntu) ([ghcr.io](https://ghcr.io)) to avoid DockerHub pull limitations.

## Automatically updated

[![Publish Docker image](https://github.com/MaastrichtU-IDS/ubuntu/workflows/Publish%20Docker%20image/badge.svg)](https://github.com/MaastrichtU-IDS/ubuntu/actions)

The image on [ghcr.io](https://ghcr.io) is automatically updated every week (Monday at 3:00 GMT+1) by a GitHub Actions workflow to match the `latest` tag of [ubuntu](https://hub.docker.com/_/ubuntu) (`20.04` in 2021)

## Run

```bash
docker run -it -v $(pwd):/root ghcr.io/maastrichtu-ids/ubuntu:latest
```

In the container:

* User, with `sudo` privileges: `root`
* Workspace path: `/root`

Set entrypoint to `tail -f /dev/null` to keep it hanging as a service.

```bash
docker run -it --entrypoint tail -v $(pwd):/root ghcr.io/maastrichtu-ids/ubuntu:latest -f /dev/null
```

## Build

Feel free to edit the `Dockerfile` to install additional packages in the image.

```bash
docker build -t ghcr.io/maastrichtu-ids/ubuntu:latest .
```

## Push

```bash
docker push ghcr.io/maastrichtu-ids/ubuntu:latest
```

