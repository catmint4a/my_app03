#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]; then
    bundle exec rails assets:precompile
fi
bin/rails webpacker:install
yarn add jquery
bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0