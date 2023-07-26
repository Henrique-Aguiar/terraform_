
FROM node:alpine

WORKDIR /usr/app

COPY package.json aws-rds/backend/package.json

RUN npm install

COPY . .

## Container ficará ouvindo os acessos na porta 3000
EXPOSE 3000

CMD npm start