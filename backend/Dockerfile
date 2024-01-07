FROM node:14


RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*


RUN pip3 install robotframework


WORKDIR /app


COPY package*.json ./

RUN npm install


COPY . .


COPY QA/automate-test/test.robot /app/QA/automate-test/test.robot


EXPOSE 3000


CMD [ "node", "app.js" ]
