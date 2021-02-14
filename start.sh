#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]; then
    yarn add rails-ujs
    bundle exec rails assets:precompile
fi

bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0