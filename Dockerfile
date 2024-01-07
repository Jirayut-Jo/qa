FROM node:14 AS build

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install robotframework robotframework-requests

RUN apt-get install -y gnupg2 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 && \
    echo "deb https://dl.k6.io/deb stable main" | tee /etc/apt/sources.list.d/k6.list && \
    apt-get update && \
    apt-get install -y k6

WORKDIR /app

COPY backend/package*.json ./

RUN npm install

COPY backend/ ./backend/

COPY automate-test/ ./automate-test/

EXPOSE 3000

CMD ["node", "backend/app.js"]

