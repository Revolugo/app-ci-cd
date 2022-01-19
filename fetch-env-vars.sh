#!/bin/sh

gem install bundler:2.0.2
bundle install --path vendor/bundle
ruby ./app-ci-cd/fetch-env-vars.rb
