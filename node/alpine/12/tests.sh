#!/bin/bash

set -euo pipefail

docker run --rm "${DOCKER_IMAGE}:${TAG}" node --version
docker run --rm "${DOCKER_IMAGE}:${TAG}" npm --version

# Test as Openshift UID
docker run --rm -u 1000090000:0 "${DOCKER_IMAGE}:${TAG}" whoami

# Test /docker-entrypoint.d/*.sh
docker run --rm -v "$(git rev-parse --show-toplevel)/.tests/test-docker-entrypoint.d.sh":/docker-entrypoint.d/test.sh "${DOCKER_IMAGE}:${TAG}" node --version | grep "TEST-ENTRYPOINT-HOOK-WORKS!"
