FROM debian:jessie

RUN apt-get update
RUN apt-get install --assume-yes nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g coffee-script
RUN mkdir -p /opt/sparkbot
COPY . /opt/sparkbot
WORKDIR /opt/sparkbot
RUN pwd && ls
RUN npm install
RUN PATH="node_modules/.bin:node_modules/hubot/node_modules/.bin:$PATH"

CMD exec node_modules/.bin/hubot --name "sparkbot"
