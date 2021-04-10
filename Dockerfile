FROM ruby:2.7.3

ENV RAILS_ENV=production
ENV PROJECT neptune

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq
RUN apt-get install -y nodejs yarn
RUN apt-get -y install imagemagick
WORKDIR /app
COPY ./src /app
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
RUN yarn add jquery@3.4.1 bootstrap@3.4.1
COPY start.sh /start.sh
RUN chmod 777 /start.sh
RUN mkdir -p tmp/sockets
RUN mkdir -p /tmp/public && \
    cp -rf /app/public/* /tmp/public
CMD ["sh", "/start.sh"]