FROM node:lts-slim

RUN yarn global add expo-cli apollo @expo/ngrok eslint typescript \
    ;

WORKDIR /usr/src/app

COPY package.json app.json yarn.lock /usr/src/app/

RUN yarn install \
    ;

# Ports of Expo Server
EXPOSE 19000-19006

ENTRYPOINT [ "yarn", "run", "start-tunnel" ]
