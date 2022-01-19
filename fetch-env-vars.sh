#!/bin/sh

cd ./app-ci-cd
gem install bundler:2.0.2
bundle install --path vendor/bundle
bundle exec ruby fetch-env-vars.rb
cd ..
