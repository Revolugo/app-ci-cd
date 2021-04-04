#!/bin/bash -e

if [ -f $(cd; pwd)/.slackrc ]; then
  . $(cd; pwd)/.slackrc
fi
  
if [ -z "${APP_SLACK_WEBHOOK:-}" ]; then
  echo 'error: Please configure Slack environment variable: ' >/dev/stderr
  echo '  APP_SLACK_WEBHOOK' >/dev/stderr
  exit 2
fi

message=$1

[ ! -z "$message" ] && curl -X POST -H 'Content-type: application/json' --data "{
              \"text\": \"${message}\",
              \"channel\": \"${APP_SLACK_CHANNEL}\"
      }" ${APP_SLACK_WEBHOOK}
