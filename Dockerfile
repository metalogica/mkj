FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential

# OS essentials
RUN apt-get install -y git curl apt-utils

# for postgres
RUN apt-get install -y libpq-dev

# for nokigiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara and webkit
RUN apt-get install -y libqtwebkit4 libqt4-dev xvfb

# for Js runtime
RUN apt-get install -y nodejs

ENV APP_HOME /mkj
RUN mkdir $APP_HOME
WORKDIR ${APP_HOME}

ADD Gemfile* $APP_HOME/
RUN gem install bundler
# solves bug: `The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
RUN bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java
RUN bundle install && yarn install

ADD . $APP_HOME