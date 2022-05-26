# Build stage
FROM node:16.15.0-alpine as build
WORKDIR /app
COPY package.json .
COPY yarn.lock .
COPY tsconfig.json .
RUN yarn install
COPY ./src ./src
RUN yarn build

FROM node:16.15.0-alpine
WORKDIR /app
COPY package.json .
RUN yarn install --production
COPY --from=build /app/dist ./dist
CMD yarn docker