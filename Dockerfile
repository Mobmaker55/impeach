FROM alpine:3.12
LABEL maintainer="Max Meinhold <mxmeinhold@gmail.com>"
ENV NODE_VERSION 14.3.0
EXPOSE 8080

USER 1001

RUN apk add 'nodejs-current=14.3.0-r0' 'nodejs-npm=12.17.0-r0'

RUN mkdir /opt/impeach
WORKDIR /opt/impeach

COPY package*.json ./

RUN npm install

COPY ./gulpfile.js ./gulpfile.js/
COPY ./src ./src/

RUN npx gulp css && rm -rf gulpfile.js && npm prune --production


CMD ["node", "src/server.js"]
