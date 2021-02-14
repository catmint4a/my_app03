#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]; then
    yarn install
    bundle exec rails assets:precompile RAILS_ENV=production
fi

bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0