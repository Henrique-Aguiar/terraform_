
FROM node:alpine

WORKDIR /usr/app

COPY package.json ./

RUN npm install

COPY . .

## Container ficará ouvindo os acessos na porta 3000
EXPOSE 8080
