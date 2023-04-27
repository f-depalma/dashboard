
# STAGE 1

FROM node:19-alpine AS build

WORKDIR /app

COPY package.json .

RUN yarn install

COPY . .

RUN yarn build

# STAGE 2

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]