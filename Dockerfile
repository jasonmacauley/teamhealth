# ./Dockerfile
FROM ruby:2.6 as base
# set some default ENV values for the image
RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    git \
    zlib1g \
    gcc \
    make \
    yarn

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

ENV APP_HOME /sbapp
RUN mkdir -p $APP_HOME/{tmp,log,gems}
WORKDIR $APP_HOME
COPY Gemfile /sbapp/Gemfile
COPY Gemfile.lock /sbapp/Gemfile.lock
RUN gem install bundler:2.0.2
RUN bundle install
COPY . /sbapp

# ------------------------------------------------------------------------------
# App secrets
# ------------------------------------------------------------------------------
#COPY _secrets /run/secrets
# We use the ENTRYPOINT directive as a helper script to decrypt the secrets
# before running the main command, you can still override it with `--entrypoint`
# option in the `docker run` if needed. The command /usr/bin/bnw_entrypoint
# requires ruby and the bnw_cli gem to be installed. All of that is available by
# default in the sb-ruby-centos image so we highly recommend using that image
# as your base image (FROM).
# COPY bin/bnw_entrypoint.sh /usr/bin
# RUN chmod +x /usr/bin/bnw_entrypoint.sh
# ENTRYPOINT ["bnw_entrypoint.sh"]

# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
#CMD ["./run.sh"]
