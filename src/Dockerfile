
FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine

LABEL org.opencontainers.image.source=https://github.com/io-digital/firebase-emulator-suite

RUN apk --no-cache --update add \
  ca-certificates \
  openjdk8-jre \
  nodejs \
  npm

RUN adduser -S firebase -G wheel
USER firebase
WORKDIR /home/firebase
RUN npm install firebase-tools
COPY ./start.sh ./

ENTRYPOINT ["/home/firebase/start.sh"]
