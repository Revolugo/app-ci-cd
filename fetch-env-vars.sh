#!/bin/sh

gem install bundler:2.0.2
bundle install --path vendor/bundle
ruby ./fetch-env-vars.rb
