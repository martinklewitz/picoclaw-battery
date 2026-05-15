#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="picoclaw-battery"
IMAGE_TAG="${1:-local}"

docker build \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  --file Dockerfile \
  .

echo "Built: ${IMAGE_NAME}:${IMAGE_TAG}"
