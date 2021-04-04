#!/bin/sh

get_package_attr() {
   ATTR=$1

   VALUE=$(cat package.json |
      grep ${ATTR} |
      head -1 |
      awk -F: '{ print $2 }' |
      sed 's/[",]//g' |
      tr -d '[[:space:]]')

   echo ${VALUE}
}

DOCKER_REGISTRY=$(get_package_attr 'docker-registry')

PACKAGE_VERSION=$(get_package_attr 'version')

TAG="v${PACKAGE_VERSION}"

while getopts ":t:" o; do
   case "${o}" in
   t)
      TAG=${OPTARG}
      ;;
   esac
done

shift $((OPTIND-1))

ACTION="${1}"

case ${ACTION} in
"BUILD")
   docker build -t ${DOCKER_REGISTRY}:${TAG} --target production .

   echo "${DOCKER_REGISTRY}:${TAG}"
   ;;
"GET_REGISTRY_URL")
   echo "https://${DOCKER_REGISTRY}"
   ;;
"PUSH")
   docker push ${DOCKER_REGISTRY}:${TAG}

   DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
   
   sh $DIR/slack.sh "🆕 New Image Pushed to: ${DOCKER_REGISTRY}:${TAG}"
   ;;
"RUN")
   docker run ${DOCKER_REGISTRY}:${TAG}
   ;;
esac
