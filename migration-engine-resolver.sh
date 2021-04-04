#!/bin/bash

set -e

ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
ENGINE="${ROOT_PATH}/revolugo-migration-engine"

if [ ! -d "$ENGINE" ]; then
  echo "WARNING: Missing migration module: revolugo-migration-engine, trying clone..."
  git clone git@bitbucket.org:revolugo/revolugo-migration-engine.git $ENGINE
  # no need to recheck, if git fails set -e will stop the script anyways
fi

if [ ! -d "$ENGINE/node_modules" ]; then
  cd $ENGINE
  npm install
fi

cd $ENGINE
node index.js --project revolugo_api $@
