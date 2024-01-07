FROM node:14 AS build


RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install robotframework



WORKDIR /app


COPY backend/package*.json ./


RUN npm install


COPY backend/ ./


COPY automate-test/ /app/automate-test/


FROM node:14


RUN apt-get update && \
    apt-get install -y python3 python3-pip


COPY --from=build /app .


WORKDIR /app


EXPOSE 3000


CMD [ "node", "app.js" ]
