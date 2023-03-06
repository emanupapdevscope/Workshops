FROM node:16.14.0-slim as build

ARG REACT_APP_BACKEND_URL
ENV REACT_APP_BACKEND_URL ${REACT_APP_BACKEND_URL}


WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm install --silent

COPY . .

RUN npm run build

FROM nginx:alpine 

COPY --from=build /app/build  /app/build/usr/share/nginx/html

