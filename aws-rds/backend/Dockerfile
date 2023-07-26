
FROM node:alpine

WORKDIR /usr/app

ADD package.json https://github.com/Henrique-Aguiar/terraform_/blob/9eb8da488426175f9fc85a06f6cd69a509bd582d/aws-rds/backend

RUN npm install

COPY . .

## Container ficará ouvindo os acessos na porta 3000
EXPOSE 3000

CMD npm start