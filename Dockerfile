# Dockerfile

FROM node:20
RUN mkdir /app
RUN mkdir /app/data

WORKDIR /app/data
#COPY src/package.json src/package-lock.json .

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN git clone https://github.com/brokengdnb/uptime-kuma /app/data/ && \
    cd /app/data/ 

RUN npm install --no-update-notifier
RUN npm run build 

EXPOSE 3001
CMD [ "npm", "start"]