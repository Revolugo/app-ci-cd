#!/bin/sh

echo $GCLOUD_API_KEYFILE | base64 -d > ~/.gcloud-api-key.json

IMAGE_REGISTRY_URL=$( sh ./app-ci-cd/docker.sh GET_REGISTRY_URL )

docker login -u _json_key --password-stdin $IMAGE_REGISTRY_URL < ~/.gcloud-api-key.json

TAG=""
TARGET=""

while getopts ":t:b:" o; do
   case "${o}" in
   t)
      TAG="-t ${OPTARG}"
      ;;
   b)
      TARGET="-b ${OPTARG}"
      ;;
   esac
done

shift $((OPTIND-1))

sh -x ./app-ci-cd/docker.sh ${TAG} ${TARGET} BUILD

sh -x ./app-ci-cd/docker.sh ${TAG} ${TARGET} PUSH
