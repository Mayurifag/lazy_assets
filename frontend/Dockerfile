FROM node:lts-slim

# Ports of Expo Server
EXPOSE 19000-19006

RUN yarn global add expo-cli apollo @expo/ngrok@^4.1.0 eslint typescript \
    ;

WORKDIR /usr/src/app

COPY . .

ENTRYPOINT [ "yarn", "run", "start-tunnel" ]
