#!/bin/bash

set -euo pipefail

docker run --rm "${DOCKER_IMAGE}:${TAG}" docker --version
docker run --rm "${DOCKER_IMAGE}:${TAG}" oc version
docker run --rm "${DOCKER_IMAGE}:${TAG}" git --version
docker run --rm "${DOCKER_IMAGE}:${TAG}" helm version -c
docker run --rm "${DOCKER_IMAGE}:${TAG}" helm-wrapper version -c
docker run --rm -e HELM_HOST=localhost "${DOCKER_IMAGE}:${TAG}" helm diff -h
docker run --rm "${DOCKER_IMAGE}:${TAG}" helm push -h
docker run --rm "${DOCKER_IMAGE}:${TAG}" helm secrets -h
docker run --rm "${DOCKER_IMAGE}:${TAG}" skopeo -v
docker run --rm "${DOCKER_IMAGE}:${TAG}" gpg --list-keys
docker run --rm "${DOCKER_IMAGE}:${TAG}" sops -v
docker run --rm "${DOCKER_IMAGE}:${TAG}" gpg-preset-passphrase -h
docker run --rm "${DOCKER_IMAGE}:${TAG}" yq --version
docker run --rm "${DOCKER_IMAGE}:${TAG}" jq --version
docker run --rm "${DOCKER_IMAGE}:${TAG}" skopeo copy docker://docker.io/library/alpine dir:///tmp/alpine.tar
docker run --rm "${DOCKER_IMAGE}:${TAG}" envsubst --version
docker run --rm "${DOCKER_IMAGE}:${TAG}" rush -V
docker run --rm -w /tmp "${DOCKER_IMAGE}:${TAG}" helm fetch --untar stable/wordpress
docker run --rm -v "$(git rev-parse --show-toplevel)/.tests/helm/gpg/test-key.gpg:/tmp/test-key.gpg" "${DOCKER_IMAGE}:${TAG}" bash -xc "gpg-keyid /tmp/test-key.gpg"
docker run --rm -v "$(git rev-parse --show-toplevel)/.tests/helm/gpg/test-key.gpg:/tmp/test-key.gpg" "${DOCKER_IMAGE}:${TAG}" bash -xc "gpg-keyid /tmp/test-key.gpg | grep 27D339D75B635157688833326DAB243C8895CCB7"
