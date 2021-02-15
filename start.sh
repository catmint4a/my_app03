#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]; then
    bundle exec rails assets:precompile RAILS_ENV=production
fi
yarn install
bundle exec bin/webpack
bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0