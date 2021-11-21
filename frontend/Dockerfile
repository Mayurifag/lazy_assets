FROM node:lts-slim

# Ports of Expo Server
EXPOSE 19000-19006

# RUN apt-get update \
#     && apt-get install -y \
#         procps \
#         build-essential \
#         python \
#     && npm install -g npm \
#     && npm install -g --force yarn \
#     && npm install -g expo-cli --unsafe-perm \
#     ;

RUN yarn global add expo-cli apollo \
    ;

WORKDIR /usr/src/app

COPY package.json app.json yarn.lock /usr/src/app/

RUN yarn install \
    ;

ENTRYPOINT [ "yarn", "run", "start" ]
# CMD ["web"]
