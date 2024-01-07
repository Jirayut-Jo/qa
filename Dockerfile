FROM node:14 AS build


RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install robotframework


RUN apt-get update && \
    apt-get install -y gnupg2 software-properties-common && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 && \
    echo "deb https://dl.k6.io/deb stable main" | tee -a /etc/apt/sources.list.d/k6.list && \
    apt-get update && \
    apt-get install -y k6 && \
    rm -rf /var/lib/apt/lists/*



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
