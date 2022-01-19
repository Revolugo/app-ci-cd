#!/bin/sh

die() {
   echo >&2 "$@"
   exit 1
}

[ "$#" -eq 2 ] || die "2 args required:\nsh fetch-env-vars.sh [name] [environment]\n$# provided"

cd ./app-ci-cd
gem install bundler:2.0.2
bundle install --path vendor/bundle
bundle exec ruby fetch-env-vars.rb $1 $2
cd ..
