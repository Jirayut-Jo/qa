FROM node:14 AS build


RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install robotframework


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y dbus


RUN apt-get update
RUN apt-get install -y gnupg2 software-properties-common

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys [CORRECT_KEY_HERE] && \
    test -n "[CORRECT_KEY_HERE]"

WORKDIR /app


COPY backend/package*.json ./


RUN npm install


COPY backend/ ./


COPY automate-test/ /app/automate-test/



FROM node:14



WORKDIR /app


COPY --from=build /app .


EXPOSE 3000


CMD [ "node", "app.js" ]
