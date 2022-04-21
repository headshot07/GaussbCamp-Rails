FROM ruby:3.1.1
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /rails-docker
COPY Gemfile /rails-docker/Gemfile
COPY Gemfile.lock /rails-docker/Gemfile.lock
ENV RAILS_ENV production
COPY . /rails-docker
RUN bundle install
RUN bundle exec rails assets:precompile
CMD ["rails", "server", "-b", "0.0.0.0"]