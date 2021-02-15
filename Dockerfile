FROM ruby:2.7

ENV RAILS_ENV=production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq
RUN apt-get install -y nodejs yarn
WORKDIR /app
COPY ./src /app
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
<<<<<<< HEAD
RUN bundle exec bin/webpack
RUN yarn add jquery@3.4.1 bootstrap@3.4.1
=======
>>>>>>> 7c4648567985480c4e90de77ce72d09f63eee183

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]