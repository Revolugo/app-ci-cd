#!/bin/sh

echo $GCLOUD_API_KEYFILE | base64 -d > ~/.gcloud-api-key.json

gcloud auth activate-service-account --key-file ~/.gcloud-api-key.json

IMAGE_REGISTRY_URL=$( sh docker.sh GET_REGISTRY_URL )

docker login -u _json_key --password-stdin $IMAGE_REGISTRY_URL < ~/.gcloud-api-key.json

OPTION=""

while getopts ":t:" o; do
   case "${o}" in
   t)
      OPTION="-t ${OPTARG}"
      ;;
   esac
done

shift $((OPTIND-1))

sh docker.sh ${OPTION} BUILD

sh docker.sh ${OPTION} PUSH
