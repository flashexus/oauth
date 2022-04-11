FROM ruby:2.7.0

ENV PROJECT ro6mysngx
ENV LANG C.UTF-8
RUN apt-get update -qq

RUN apt-get install -y vim
########################################################################
# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

#######################################################################
RUN mkdir /ro6mysngx
WORKDIR /ro6mysngx

########################Rails setting#################################
COPY Gemfile /ro6mysngx/Gemfile
COPY Gemfile.lock /ro6mysngx/Gemfile.lock
RUN yarn install --check-files
ADD . /ro6mysngx
RUN bundle install && rails webpacker:install


VOLUME /$PROJECT
# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets

RUN mkdir -p /tmp/public && \
    cp -rf /ro6mysngx/public/* /tmp/public