#!/bin/sh

echo $GCLOUD_API_KEYFILE | base64 -d >~/.gcloud-api-key.json

IMAGE_REGISTRY_URL=$(sh ./app-ci-cd/docker.sh GET_REGISTRY_URL)

docker login -u _json_key --password-stdin $IMAGE_REGISTRY_URL <~/.gcloud-api-key.json
