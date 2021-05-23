#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]; then
    bundle exec rails assets:precompile
fi
# cp -rf /tmp/public/* /app/public/
# mkdir -p tmp/sockets
# sudo service nginx start
# cd /app
# bin/setup
bundle exec pumactl start
# bundle exec puma -C config/puma.rb