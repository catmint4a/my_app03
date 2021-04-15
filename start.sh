#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]; then
    bundle exec rails assets:precompile
fi
cp -rf /tmp/public/* /app/public/
mkdir -p tmp/sockets
bundle exec puma -C config/puma.rb -e production