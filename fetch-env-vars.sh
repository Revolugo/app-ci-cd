#!/bin/sh

gem install bundler:2.0.2
bundle install
ruby ./fetch-env-vars.rb
