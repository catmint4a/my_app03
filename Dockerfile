FROM ruby:2.7.3

ENV RAILS_ENV=production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq
RUN apt-get install -y nodejs yarn
# RUN apt-get install -y build-essential \
#   libpq-dev \
#   sudo \
#   nginx
RUN apt-get -y install imagemagick
WORKDIR /app
COPY ./src /app
# RUN bundle config --local set path 'vendor/bundle' \
#   && bundle install
RUN gem install bundler

RUN ["apt-get", "install", "-y", "vim"]
ENV ENTRYKIT_VERSION 0.4.0

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink

# RUN bundle install
# RUN groupadd nginx
# RUN useradd -g nginx nginx
# ADD nginx/nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod 777 /start.sh
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
RUN mkdir -p /tmp/public && \
    cp -rf /app/public/* /tmp/public
ENTRYPOINT [ \
  "prehook", "ruby -v", "--", \
  "prehook", "bundle install -j3 --path /usr/local/bundle", "--"]
CMD ["sh", "/start.sh"]